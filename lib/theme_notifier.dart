import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  Color _backgroundColor = Colors.black;
  Color _textColor = Colors.white70;
  double _fontSize = 16.0;

  Color get backgroundColor => _backgroundColor;
  Color get textColor => _textColor;
  double get fontSize => _fontSize;

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

  List<Map<String, dynamic>> get colorThemes => _colorThemes;

  ThemeNotifier() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _fontSize = prefs.getDouble('reader_fontSize') ?? 16.0;
    final themeName = prefs.getString('reader_themeName') ?? 'Dark';
    final theme = _colorThemes.firstWhere(
          (t) => t['name'] == themeName,
      orElse: () => _colorThemes.first,
    );
    _backgroundColor = theme['background']!;
    _textColor = theme['text']!;
    notifyListeners();
  }

  Future<void> updateFontSize(double newSize) async {
    _fontSize = newSize;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('reader_fontSize', _fontSize);
    notifyListeners();
  }

  Future<void> updateTheme(String themeName) async {
    final theme = _colorThemes.firstWhere(
          (t) => t['name'] == themeName,
      orElse: () => _colorThemes.first,
    );
    _backgroundColor = theme['background']!;
    _textColor = theme['text']!;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('reader_themeName', themeName);
    notifyListeners();
  }
}
