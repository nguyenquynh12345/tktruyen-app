import 'package:flutter/material.dart';
import 'package:heheheh/screens/login/login_screen.dart';
import 'package:heheheh/screens/login/register_screen.dart';
import 'package:heheheh/screens/nav/main_nav_screen.dart';

import 'package:heheheh/screens/profile/account_detail_screen.dart';
import 'package:heheheh/screens/home/story_detail_screen.dart';
import 'package:heheheh/screens/home/chapter_reader.dart';
import 'package:heheheh/routes/slide_page_route.dart';

import 'package:heheheh/screens/settings/settings_screen.dart';
import 'package:heheheh/screens/profile/viewed_stories_screen.dart';
import 'package:provider/provider.dart';
import 'package:heheheh/theme_notifier.dart';
import 'package:heheheh/favorite_notifier.dart';
import 'package:heheheh/viewed_stories_notifier.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => FavoriteNotifier()),
        ChangeNotifierProvider(create: (_) => ViewedStoriesNotifier()),
      ],
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
            case '/viewed_stories':
              return SlidePageRoute(page: const ViewedStoriesScreen());
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
