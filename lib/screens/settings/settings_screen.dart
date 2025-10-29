import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:heheheh/theme_notifier.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    // No need to load settings here, ThemeNotifier handles it
  }

  void _onFontSizeChanged(ThemeNotifier themeNotifier, double newSize) {
    themeNotifier.updateFontSize(newSize);
  }

  void _onColorChanged(ThemeNotifier themeNotifier, String themeName) {
    themeNotifier.updateTheme(themeName);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final fontSize = themeNotifier.fontSize;
        final backgroundColor = themeNotifier.backgroundColor;
        final textColor = themeNotifier.textColor;
        final colorThemes = themeNotifier.colorThemes;

        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: Text('Cài đặt đọc truyện', style: TextStyle(color: textColor)),
            backgroundColor: backgroundColor,
            iconTheme: IconThemeData(color: textColor),
          ),
          body: ListView(
            children: [
              ListTile(
                title: Text('Kích thước chữ', style: TextStyle(color: textColor)),
                subtitle: Slider(
                  value: fontSize,
                  min: 12.0,
                  max: 24.0,
                  divisions: 12,
                  onChanged: (newSize) => _onFontSizeChanged(themeNotifier, newSize),
                  activeColor: Theme.of(context).colorScheme.primary,
                  inactiveColor: textColor.withOpacity(0.3),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Chủ đề màu sắc', style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
              ),
              ...colorThemes.map((theme) {
                final themeName = theme['name'] as String;
                final themeBackground = theme['background'] as Color;
                // final themeText = theme['text'] as Color; // Not directly used here
                return RadioListTile<String>(
                  title: Text(themeName, style: TextStyle(color: textColor)),
                  value: themeName,
                  groupValue: colorThemes.firstWhere((t) => t['background'] == backgroundColor)['name'],
                  onChanged: (value) {
                    if (value != null) {
                      _onColorChanged(themeNotifier, value); 
                    }
                  },
                  activeColor: Theme.of(context).colorScheme.primary,
                  tileColor: themeBackground.withOpacity(0.2),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}