import 'package:flutter/material.dart';
import 'package:heheheh/screens/home/home_screen.dart';
import 'package:heheheh/screens/profile/menu_screen.dart';
import 'package:heheheh/screens/search/search_screen.dart';
import 'package:provider/provider.dart';
import 'package:heheheh/theme_notifier.dart';
import 'bottom_nav_bar.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _selectedIndex = 1;

  final List<String> _pageTitles = const [
    'Tag',
    'Khám Phá',
    'Tìm Truyện',
    'Offline',
    'Menu',
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget _buildPageScaffold(int index, Widget body, Color backgroundColor, Color textColor) {
    return Scaffold(
      key: ValueKey('page_${index}_${backgroundColor.value}_${textColor.value}'),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(_pageTitles[index], style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: textColor, displayColor: textColor),
          iconTheme: IconThemeData(color: textColor),
        ),
        child: body,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        final backgroundColor = themeNotifier.backgroundColor;
        final textColor = themeNotifier.textColor;
        final appBarColor = themeNotifier.colorThemes.firstWhere((t) => t['background'] == backgroundColor)['appBar'] as Color? ?? Colors.blue;

        final List<Widget> _pages = [
          _buildPageScaffold(0, SearchScreenWidget(backgroundColor: backgroundColor, textColor: textColor), backgroundColor, textColor),
          _buildPageScaffold(1, HomeScreenBody(backgroundColor: backgroundColor, textColor: textColor), backgroundColor, textColor),
          _buildPageScaffold(2, Center(
            child: Text('Tìm Truyện', style: TextStyle(color: textColor)),
          ), backgroundColor, textColor),
          _buildPageScaffold(3, Center(
            child: Text('Offline', style: TextStyle(color: textColor)),
          ), backgroundColor, textColor),
          MenuScreen(backgroundColor: backgroundColor, textColor: textColor),
        ];

        return Scaffold(
          backgroundColor: backgroundColor,
          body: IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            backgroundColor: backgroundColor,
            selectedItemColor: appBarColor,
            unselectedItemColor: textColor.withOpacity(0.7),
          ),
        );
      },
    );
  }
}
