import 'package:flutter/material.dart';
import 'package:heheheh/screens/home/widgets/chapter_page.dart';
import 'package:heheheh/screens/home/widgets/reader_controls_overlay.dart';
import 'package:heheheh/screens/home/widgets/reader_settings_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool _showControls = false;

  // Reader display settings
  double _fontSize = 16.0;
  Color _backgroundColor = Colors.black;
  Color _textColor = Colors.white70;

  final List<Map<String, dynamic>> _colorThemes = [
    {
      'name': 'Dark',
      'background': Colors.black,
      'text': Colors.white70,
      'appBar': Colors.blueAccent
    },
    {
      'name': 'Sepia',
      'background': const Color(0xFFFBF0D9),
      'text': const Color(0xFF5B4636),
      'appBar': const Color(0xFF005792)
    },
    {
      'name': 'Light',
      'background': Colors.white,
      'text': Colors.black87,
      'appBar': Colors.blue
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.chapterIndex);
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _fontSize = prefs.getDouble('reader_fontSize') ?? 16.0;
      final themeName = prefs.getString('reader_themeName') ?? 'Dark';
      final theme = _colorThemes.firstWhere(
        (t) => t['name'] == themeName,
        orElse: () => _colorThemes.first,
      );
      _backgroundColor = theme['background']!;
      _textColor = theme['text']!;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('reader_fontSize', _fontSize);
    final themeName = _colorThemes.firstWhere((t) => t['background'] == _backgroundColor)['name'];
    await prefs.setString('reader_themeName', themeName);
  }

  void _onFontSizeChanged(double newSize) {
    setState(() {
      _fontSize = newSize;
    });
    _saveSettings();
  }

  void _onColorChanged(Color newBackgroundColor, Color newTextColor) {
    setState(() {
      _backgroundColor = newBackgroundColor;
      _textColor = newTextColor;
    });
    _saveSettings();
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = _colorThemes.firstWhere((theme) => theme['background'] == _backgroundColor, orElse: () => _colorThemes.first);
    final appBarColor = currentTheme['appBar'] as Color? ?? Colors.blueAccent;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: GestureDetector(
        onTap: () {
          setState(() {
            _showControls = !_showControls;
          });
        },
        child: Stack(
          children: [
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollStartNotification && _showControls) {
                  setState(() {
                    _showControls = false;
                  });
                }
                return false;
              },
              child: PageView.builder(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                itemCount: widget.chapters.length,
                itemBuilder: (context, index) {
                  return ChapterPage(
                    storyId: widget.storyId,
                    storyTitle: widget.storyTitle,
                    chapter: widget.chapters[index],
                    fontSize: _fontSize,
                    backgroundColor: _backgroundColor,
                    textColor: _textColor,
                    appBarColor: appBarColor,
                  );
                },
              ),
            ),
            if (_showControls)
              ReaderControlsOverlay(
                onBack: () => Navigator.of(context).pop(),
                onSettings: () {
                  showReaderSettingsModal(
                    context: context,
                    initialFontSize: _fontSize,
                    initialBackgroundColor: _backgroundColor,
                    initialTextColor: _textColor,
                    colorThemes: _colorThemes,
                    onFontSizeChanged: _onFontSizeChanged,
                    onColorChanged: _onColorChanged,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}