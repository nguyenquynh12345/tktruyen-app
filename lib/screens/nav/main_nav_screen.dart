import 'package:flutter/material.dart';
import 'package:heheheh/screens/nav/bottom_nav_bar.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text('🏠 Home Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('🔍 Search Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('🔔 Notifications', style: TextStyle(fontSize: 24))),
    Center(child: Text('👤 Profile Page', style: TextStyle(fontSize: 24))),
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavBar(
        initialIndex: _selectedIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
