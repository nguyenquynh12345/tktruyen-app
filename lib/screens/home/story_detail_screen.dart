import 'package:flutter/material.dart';
import 'package:heheheh/api/api_service.dart';
import 'package:provider/provider.dart';
import 'package:heheheh/theme_notifier.dart';
import 'chapter_reader.dart';

class StoryDetailScreen extends StatefulWidget {
  final int storyId;

  const StoryDetailScreen({
    super.key,
    required this.storyId,
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
  String _storyTitle = ''; // To store the fetched story title

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchStoryDetailsAndChapters();

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

  Future<void> _fetchStoryDetailsAndChapters() async {
    try {
      // Fetch story details to get the title
      final storyDetails = await StoryService.getById(widget.storyId);
      _storyTitle = storyDetails.storyName; // Assuming storyName is the title

      final List<dynamic> data = await StoryService.getListChapterById(widget.storyId, _currentPage);

      setState(() {
        _chapters = data.cast<Map<String, dynamic>>();
        _isLoading = false;
        _hasMore = data.isNotEmpty; // nếu rỗng -> hết dữ liệu
      });
    } catch (e) {
      debugPrint('Lỗi tải chi tiết truyện hoặc danh sách chương: $e');
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
        }
        else {
          _chapters.addAll(moreData.cast<Map<String, dynamic>>());
        }
      });
    }
    catch (e) {
      debugPrint('Lỗi load thêm chương: $e');
    }
    finally {
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
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final backgroundColor = themeNotifier.backgroundColor;
        final textColor = themeNotifier.textColor;
        final appBarColor = themeNotifier.colorThemes.firstWhere((t) => t['background'] == backgroundColor)['appBar'] as Color? ?? Colors.blueAccent;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title:
            Text(_storyTitle, style: TextStyle(color: textColor)),
            backgroundColor: backgroundColor,
            iconTheme: IconThemeData(color: textColor),
          ),
          body: _isLoading
              ? Center(
            child: CircularProgressIndicator(color: textColor),
          )
              : _chapters.isEmpty
              ? Center(
            child: Text('Không có chương nào',
                style: TextStyle(color: textColor)),
          )
              : RefreshIndicator(
            color: appBarColor,
            backgroundColor: backgroundColor,
            onRefresh: () async {
              _currentPage = 1;
              _hasMore = true;
              await _fetchStoryDetailsAndChapters();
            },
            child: ListView.builder(
              controller: _scrollController,
              itemCount:
              _chapters.length + (_isLoadingMore ? 1 : 0), // +1 cho loader
              itemBuilder: (context, index) {
                if (index >= _chapters.length) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                        child: CircularProgressIndicator(
                            color: textColor)),
                  );
                }

                final chapter = _chapters[index];
                final title =
                    chapter['title'] ?? 'Chương ${index + 1}';
                // final chapterNumber =
                //     chapter['chapterNumber'] ?? index + 1;

                return ListTile(
                  title: Text(title,
                      style: TextStyle(color: textColor)),
                  trailing: Icon(Icons.chevron_right,
                      color: textColor.withOpacity(0.7)),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/chapter_reader',
                      arguments: {
                        'storyId': widget.storyId,
                        'storyTitle': _storyTitle,
                        'chapterIndex': index,
                        'chapters': _chapters,
                      },
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

