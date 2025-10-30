import 'package:flutter/material.dart';
import 'package:heheheh/api/api_service.dart';
import 'package:heheheh/models/story.dart';
import 'package:provider/provider.dart';
import 'package:heheheh/theme_notifier.dart';
import 'package:heheheh/favorite_notifier.dart';
import 'package:heheheh/viewed_stories_notifier.dart';
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
  bool _isFavorite = false;
  Story? _story;

  int _currentPage = 1;
  List<Map<String, dynamic>> _chapters = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchStoryDetailsAndChapters();

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
      final storyDetails = await StoryService.getById(widget.storyId);
      _story = storyDetails;
      // Check favorite status
      _checkIfFavorite();
      // Add to viewed stories
      Provider.of<ViewedStoriesNotifier>(context, listen: false).addViewedStory(_story!);

      final List<dynamic> data = await StoryService.getListChapterById(widget.storyId, _currentPage);

      setState(() {
        _chapters = data.cast<Map<String, dynamic>>();
        _isLoading = false;
        _hasMore = data.isNotEmpty;
      });
    } catch (e) {
      debugPrint('Lỗi tải chi tiết truyện hoặc danh sách chương: $e');
      setState(() => _isLoading = false);
    }
  }

  Future<void> _checkIfFavorite() async {
    if (_story == null) return;
    final favoriteNotifier = Provider.of<FavoriteNotifier>(context, listen: false);
    setState(() {
      _isFavorite = favoriteNotifier.isFavorite(widget.storyId);
    });
  }

  Future<void> _toggleFavorite() async {
    if (_story == null) return;
    final favoriteNotifier = Provider.of<FavoriteNotifier>(context, listen: false);

    if (_isFavorite) {
      await favoriteNotifier.removeFavorite(widget.storyId);
    } else {
      await favoriteNotifier.addFavorite(_story!);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
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
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final backgroundColor = themeNotifier.backgroundColor;
        final textColor = themeNotifier.textColor;
        final appBarColor = themeNotifier.colorThemes.firstWhere((t) => t['background'] == backgroundColor)['appBar'] as Color? ?? Colors.blueAccent;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text(_story?.storyName ?? '', style: TextStyle(color: textColor)),
            backgroundColor: backgroundColor,
            iconTheme: IconThemeData(color: textColor),
            actions: [
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? Colors.red : textColor,
                ),
                onPressed: _toggleFavorite,
              ),
            ],
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
                        itemCount: _chapters.length + (_isLoadingMore ? 1 : 0),
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
                          final title = chapter['title'] ?? 'Chương ${index + 1}';

                          return ListTile(
                            title: Text(title, style: TextStyle(color: textColor)),
                            trailing: Icon(Icons.chevron_right, color: textColor.withOpacity(0.7)),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/chapter_reader',
                                arguments: {
                                  'storyId': widget.storyId,
                                  'storyTitle': _story?.storyName ?? '',
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
