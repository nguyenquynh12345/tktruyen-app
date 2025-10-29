import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountDetailScreen extends StatefulWidget {
  const AccountDetailScreen({super.key});

  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  Map<String, dynamic>? _user;

  Color _backgroundColor = const Color(0xFFF5F5F5);
  Color _textColor = Colors.black;

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
    _loadColorPreferences();
    _loadUserData();
  }

  Future<void> _loadColorPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final themeName = prefs.getString('reader_themeName') ?? 'Light'; // Default to Light theme
      final theme = _colorThemes.firstWhere(
        (t) => t['name'] == themeName,
        orElse: () => _colorThemes.firstWhere((t) => t['name'] == 'Light'), // Fallback to Light
      );
      _backgroundColor = theme['background']!;
      _textColor = theme['text']!;
    });
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');
    if (userString != null) {
      setState(() {
        _user = jsonDecode(userString);
      });
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('user');
    // Navigate back to the main screen and ensure menu is updated
    Navigator.of(context).popUntil((route) => route.isFirst); // Pop all routes until first
    Navigator.pushReplacementNamed(context, '/home'); // Go to home and rebuild
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: _textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Thông tin tài khoản', style: TextStyle(color: _textColor)),
        centerTitle: true,
      ),
      body: _user == null
          ? Center(child: CircularProgressIndicator(color: _textColor))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email: ${_user!['email']}',
                    style: TextStyle(fontSize: 18, color: _textColor),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'ID: ${_user!['id']}',
                    style: TextStyle(fontSize: 18, color: _textColor),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Trạng thái hoạt động: ${(_user!['is_active'] ?? false) ? 'Có' : 'Không'}',
                    style: TextStyle(fontSize: 18, color: _textColor),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _logout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                        ),
                        child: const Text(
                          'Đăng xuất',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
