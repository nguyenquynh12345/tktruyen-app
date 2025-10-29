import 'package:flutter/material.dart';
import 'package:heheheh/screens/login/login_screen.dart';
import 'package:heheheh/screens/login/register_screen.dart';
import 'package:heheheh/screens/nav/main_nav_screen.dart';
import 'package:heheheh/screens/profile/menu_screen.dart';
import 'package:heheheh/screens/profile/account_detail_screen.dart';
import 'package:heheheh/screens/home/story_detail_screen.dart';
import 'package:heheheh/screens/home/chapter_reader.dart';
import 'package:heheheh/routes/slide_page_route.dart';

import 'package:heheheh/screens/settings/settings_screen.dart';
import 'package:provider/provider.dart';
import 'package:heheheh/theme_notifier.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MaterialApp(
        title: 'Modern Flutter App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFDF20)),
          useMaterial3: true,
        ),
        initialRoute: '/home',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return SlidePageRoute(page: const LoginScreen());
            case '/register':
              return SlidePageRoute(page: const RegisterScreen());
            case '/account_detail':
              return SlidePageRoute(page: const AccountDetailScreen());
            case '/story_detail':
              final args = settings.arguments as Map<String, dynamic>;
              return SlidePageRoute(page: StoryDetailScreen(storyId: args['storyId']));
            case '/chapter_reader':
              final args = settings.arguments as Map<String, dynamic>;
              return SlidePageRoute(page: ChapterReader(
                storyId: args['storyId'],
                storyTitle: args['storyTitle'],
                chapterIndex: args['chapterIndex'],
                chapters: args['chapters'],
              ));
            case '/settings':
              return SlidePageRoute(page: const SettingsScreen());
            case '/home':
              return MaterialPageRoute(builder: (context) => const MainNavScreen());
            default:
              return MaterialPageRoute(builder: (context) => const MainNavScreen());
          }
        },
      ),
    );
  }
}
