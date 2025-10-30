import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:heheheh/api/api_service.dart';
import 'package:heheheh/models/chapter.dart';
import 'package:heheheh/theme_notifier.dart';
import 'package:provider/provider.dart';

class ChapterReader extends StatefulWidget {
  final int storyId;
  final String storyTitle;
  final int chapterIndex;
  final List<Map<String, dynamic>> chapters;

  const ChapterReader({
    super.key,
    required this.storyId,
    required this.storyTitle,
    required this.chapterIndex,
    required this.chapters,
  });

  @override
  State<ChapterReader> createState() => _ChapterReaderState();
}

class _ChapterReaderState extends State<ChapterReader> {
  late PageController _pageController;
  late int _currentChapterIndex;
  bool _isUIHidden = false;
  final Map<int, Future<Chapter>> _chapterFutures = {};

  @override
  void initState() {
    super.initState();
    _currentChapterIndex = widget.chapterIndex;
    _pageController = PageController(initialPage: _currentChapterIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<Chapter> _getChapterFuture(int index) {
    if (!_chapterFutures.containsKey(index)) {
      _chapterFutures[index] = StoryService.getChapterById(
        widget.storyId,
        widget.chapters[index]['chapterNumber'],
      );
    }
    return _chapterFutures[index]!;
  }

  void _toggleUI() {
    setState(() {
      _isUIHidden = !_isUIHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final backgroundColor = themeNotifier.backgroundColor;
    final textColor = themeNotifier.textColor;
    final appBarColor = themeNotifier.colorThemes.firstWhere((t) => t['background'] == backgroundColor)['appBar'] as Color? ?? Colors.blueAccent;

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true, // Allow body to extend behind AppBar
      extendBody: true, // Allow body to extend behind BottomAppBar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // Standard AppBar height
        child: AnimatedOpacity(
          opacity: _isUIHidden ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 200),
          child: AppBar(
            title: Text(widget.storyTitle, style: TextStyle(color: textColor)),
            backgroundColor: Colors.transparent, // Make AppBar transparent
            elevation: 0, // Remove AppBar shadow
            iconTheme: IconThemeData(color: textColor), // Ensure back button is visible
            foregroundColor: textColor, // Ensure title and actions are visible
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: textColor),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
          ),
        ),
      ),
      body: GestureDetector(
        onTap: _toggleUI,
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.chapters.length,
          onPageChanged: (index) {
            setState(() {
              _currentChapterIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return FutureBuilder<Chapter>(
              future: _getChapterFuture(index),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator(color: textColor));
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Lỗi tải nội dung chương', style: TextStyle(color: textColor)));
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('Không có dữ liệu', style: TextStyle(color: textColor)));
                }

                final chapter = snapshot.data!;
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Html(
                          data: chapter.content,
                          style: {
                            "body": Style(
                              color: textColor,
                              fontSize: FontSize(16),
                            ),
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      bottomNavigationBar: AnimatedOpacity(
        opacity: _isUIHidden ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: BottomAppBar(
          color: backgroundColor.withOpacity(0.2), // Make BottomAppBar semi-transparent
          elevation: 0, // Remove BottomAppBar shadow
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                color: textColor,
                onPressed: _currentChapterIndex > 0
                    ? () => _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        )
                    : null,
              ),
              Expanded(
                child: Text(
                  widget.chapters[_currentChapterIndex]['title'] ?? 'Chương ${_currentChapterIndex + 1}',
                  style: TextStyle(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                color: textColor,
                onPressed: _currentChapterIndex < widget.chapters.length - 1
                    ? () => _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}