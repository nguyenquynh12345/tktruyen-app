import 'package:flutter/material.dart';
import 'package:heheheh/screens/home/widgets/chapter_page.dart';
import 'package:heheheh/screens/home/widgets/reader_controls_overlay.dart';
import 'package:heheheh/screens/home/widgets/reader_settings_modal.dart';
import 'package:provider/provider.dart';
import 'package:heheheh/theme_notifier.dart';

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

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.chapterIndex);
  }

  void _onFontSizeChanged(ThemeNotifier themeNotifier, double newSize) {
    themeNotifier.updateFontSize(newSize);
  }

  void _onColorChanged(ThemeNotifier themeNotifier, Color newBackgroundColor, Color newTextColor) {
    final themeName = themeNotifier.colorThemes.firstWhere((t) => t['background'] == newBackgroundColor)['name'];
    themeNotifier.updateTheme(themeName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final fontSize = themeNotifier.fontSize;
        final backgroundColor = themeNotifier.backgroundColor;
        final textColor = themeNotifier.textColor;
        final currentTheme = themeNotifier.colorThemes.firstWhere((theme) => theme['background'] == backgroundColor, orElse: () => themeNotifier.colorThemes.first);
        final appBarColor = currentTheme['appBar'] as Color? ?? Colors.blueAccent;

        return Scaffold(
          backgroundColor: backgroundColor,
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
                        fontSize: fontSize,
                        backgroundColor: backgroundColor,
                        textColor: textColor,
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
                        initialFontSize: fontSize,
                        initialBackgroundColor: backgroundColor,
                        initialTextColor: textColor,
                        colorThemes: themeNotifier.colorThemes,
                        onFontSizeChanged: (newSize) => _onFontSizeChanged(themeNotifier, newSize),
                        onColorChanged: (newBg, newText) => _onColorChanged(themeNotifier, newBg, newText),
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}