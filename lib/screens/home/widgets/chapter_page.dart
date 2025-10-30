import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:heheheh/api/api_service.dart';

import '../../../models/chapter.dart';

class ChapterPage extends StatefulWidget {
  final int storyId;
  final String storyTitle;
  final Map<String, dynamic> chapter;
  final double fontSize;
  final Color backgroundColor;
  final Color textColor;
  final Color appBarColor;

  const ChapterPage({
    super.key,
    required this.storyId,
    required this.storyTitle,
    required this.chapter,
    required this.fontSize,
    required this.backgroundColor,
    required this.textColor,
    required this.appBarColor,
  });

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  late Future<Chapter> _chapterFuture;

  @override
  void initState() {
    super.initState();
    _fetchChapterContent();
  }

  void _fetchChapterContent() {
    final chapterNumber = widget.chapter['chapterNumber'] as int;
    _chapterFuture = StoryService.getChapterById(widget.storyId, chapterNumber);
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.chapter['title'] as String? ?? 'Chapter';

    return FutureBuilder<Chapter>(
      future: _chapterFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingPage(title);
        } else if (snapshot.hasError) {
          return _buildErrorPage(title, snapshot.error.toString());
        } else if (snapshot.hasData) {
          return _buildChapterPage(snapshot.data!.title, snapshot.data!.content);
        } else {
          return _buildLoadingPage(title);
        }
      },
    );
  }

  Widget _buildChapterPage(String title, String content) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.storyTitle,
            style: TextStyle(
              color: widget.appBarColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: widget.textColor.withOpacity(0.9),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Html(
            data: content,
            style: {
              "body": Style(
                color: widget.textColor,
                fontSize: FontSize(widget.fontSize),
                lineHeight: LineHeight.number(1.6),
                textAlign: TextAlign.justify,
              ),
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingPage(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Text(
            title,
            style: TextStyle(
              color: widget.textColor.withOpacity(0.9),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorPage(String title, String error) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Text(
            title,
            style: TextStyle(
              color: widget.textColor.withOpacity(0.9),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'Error loading chapter: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
