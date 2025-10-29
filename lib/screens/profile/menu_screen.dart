import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuScreen extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;

  const MenuScreen({
    super.key,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool _isLoggedIn = false;
  Map<String, dynamic>? _user;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    final userString = prefs.getString('user');

    setState(() {
      _isLoggedIn = token != null;
      if (userString != null) {
        _user = jsonDecode(userString);
      }
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('user');
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: widget.backgroundColor,
        elevation: 0,
        foregroundColor: widget.textColor,
      ),
      body: _isLoggedIn ? _buildLoggedInMenu() : _buildLoggedOutMenu(),
    );
  }

  Widget _buildLoggedOutMenu() {
    return ListView(
      children: [
        _buildSectionTitle('TÀI KHOẢN'),
        _buildMenuItem(Icons.login, 'Đăng nhập', onTap: () async {
          await Navigator.pushNamed(context, '/login');
          _checkLoginStatus();
        }),
        _buildMenuItem(Icons.person_add, 'Đăng ký', onTap: () {
          Navigator.pushNamed(context, '/register');
        }),
      ],
    );
  }

  Widget _buildLoggedInMenu() {
    return ListView(
      children: [
        _buildProfileSection(),
        _buildSectionTitle('LỊCH SỬ TRÊN TÀI KHOẢN'),
        _buildMenuItem(Icons.history, 'Truyện đã xem'),
        _buildMenuItem(Icons.favorite_border, 'Truyện đã thích'),
        _buildMenuItem(Icons.download_outlined, 'Truyện đã tải'),
        _buildMenuItem(Icons.notifications_none, 'Truyện đã theo dõi'),
        _buildMenuItem(Icons.people_alt_outlined, 'Người đang theo dõi'),
        _buildSectionTitle('THÔNG BÁO'),
        _buildMenuItem(Icons.notifications_outlined, 'Thông báo của tôi'),
        _buildSectionTitle('DANH SÁCH TRUYỆN'),
        _buildMenuItem(Icons.collections_bookmark_outlined, 'Bộ sưu tập của tôi'),
        _buildMenuItem(Icons.favorite_outline, 'Bộ sưu tập yêu thích'),
        _buildMenuItem(Icons.settings, 'Cài đặt', onTap: () async {
          await Navigator.pushNamed(context, '/settings');
          // No need to _checkLoginStatus() here, but if settings affect login state, it would be here.
        }),
        const SizedBox(height: 20),

      ],
    );
  }

  Widget _buildProfileSection() {
    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(context, '/account_detail');
        _checkLoginStatus(); // Refresh login status after returning
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.orange,
              child: Text(
                _user?['email']?[0].toUpperCase() ?? 'A',
                style: const TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _user?['email'] ?? 'User',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: widget.textColor),
                ),
                Text('TYT - Truyện Online, Offline', style: TextStyle(color: widget.textColor.withOpacity(0.7))),
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: widget.textColor.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: TextStyle(color: widget.textColor.withOpacity(0.6), fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: widget.textColor),
      title: Text(title, style: TextStyle(color: widget.textColor)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: widget.textColor.withOpacity(0.7)),
      onTap: onTap,
    );
  }
}
