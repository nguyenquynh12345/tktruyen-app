import 'package:flutter/material.dart';
import 'package:heheheh/api/api_service.dart';
import 'chapter_reader.dart';

class StoryDetailScreen extends StatefulWidget {
  final int storyId;
  final String storyTitle;

  const StoryDetailScreen({
    super.key,
    required this.storyId,
    required this.storyTitle,
  });

  @override
  State<StoryDetailScreen> createState() => _StoryDetailScreenState();
}

class _StoryDetailScreenState extends State<StoryDetailScreen> {
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  int _currentPage = 1;
  List<Map<String, dynamic>> _chapters = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchChapters();

    // Lắng nghe khi scroll tới cuối danh sách để load thêm
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100 &&
          !_isLoadingMore &&
          _hasMore) {
        _loadMore();
      }
    });
  }

  Future<void> _fetchChapters() async {
    try {
      final List<dynamic> data = await StoryService.getListChapterById(widget.storyId, _currentPage);

      setState(() {
        _chapters = data.cast<Map<String, dynamic>>();
        _isLoading = false;
        _hasMore = data.isNotEmpty; // nếu rỗng -> hết dữ liệu
      });
    } catch (e) {
      debugPrint('Lỗi tải danh sách chương: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadMore() async {
    setState(() => _isLoadingMore = true);
    try {
      _currentPage++;
      final List<dynamic> moreData = await StoryService.getListChapterById(widget.storyId, _currentPage);

      setState(() {
        if (moreData.isEmpty) {
          _hasMore = false;
        } else {
          _chapters.addAll(moreData.cast<Map<String, dynamic>>());
        }
      });
    } catch (e) {
      debugPrint('Lỗi load thêm chương: $e');
    } finally {
      setState(() => _isLoadingMore = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title:
        Text(widget.storyTitle, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Colors.white),
      )
          : _chapters.isEmpty
          ? const Center(
        child: Text('Không có chương nào',
            style: TextStyle(color: Colors.white70)),
      )
          : RefreshIndicator(
        color: Colors.blue,
        backgroundColor: Colors.black,
        onRefresh: () async {
          _currentPage = 1;
          _hasMore = true;
          await _fetchChapters();
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount:
          _chapters.length + (_isLoadingMore ? 1 : 0), // +1 cho loader
          itemBuilder: (context, index) {
            if (index >= _chapters.length) {
              return const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                    child: CircularProgressIndicator(
                        color: Colors.white)),
              );
            }

            final chapter = _chapters[index];
            final title =
                chapter['title'] ?? 'Chương ${index + 1}';
            final chapterNumber =
                chapter['chapterNumber'] ?? index + 1;

            return ListTile(
              title: Text(title,
                  style: const TextStyle(color: Colors.white)),
              trailing: const Icon(Icons.chevron_right,
                  color: Colors.white54),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChapterReader(
                      storyId: widget.storyId,
                      storyTitle: widget.storyTitle,
                      chapterIndex: index, // Sử dụng index của list
                      chapters: _chapters,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
