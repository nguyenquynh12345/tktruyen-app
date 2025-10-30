import 'package:flutter/material.dart';
import 'package:heheheh/screens/favorites/favorite_screen.dart';
import 'package:heheheh/screens/home/home_screen.dart';
import 'package:heheheh/screens/profile/menu_screen.dart';
import 'package:heheheh/screens/search/search_screen.dart';
import 'package:heheheh/screens/settings/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:heheheh/theme_notifier.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final backgroundColor = themeNotifier.backgroundColor;
        final textColor = themeNotifier.textColor;
        final unselectedColor = textColor.withOpacity(0.7);

        List<Widget> getPages() {
          return [
            HomeScreen(backgroundColor: backgroundColor, textColor: textColor),
            SearchScreen(backgroundColor: backgroundColor, textColor: textColor),
            const FavoriteScreen(),
            MenuScreen(backgroundColor: backgroundColor, textColor: textColor),
          ];
        }

        return Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: getPages(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            backgroundColor: backgroundColor,
            selectedItemColor: const Color(0xFFFFDF20),
            unselectedItemColor: unselectedColor,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Trang chủ',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined),
                activeIcon: Icon(Icons.search),
                label: 'Tìm kiếm',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.book_outlined),
                activeIcon: Icon(Icons.book),
                label: 'Tủ sách',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Cá nhân',
              ),
            ],
          ),
        );
      },
    );
  }
}
