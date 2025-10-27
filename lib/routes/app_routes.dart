import 'package:flutter/material.dart';
import 'package:heheheh/screens/login/login_screen.dart';
import 'package:heheheh/screens/nav/main_nav_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFDF20)),
        useMaterial3: true,
      ),
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const LoginScreen(),
      bottomNavigationBar: const MainNavScreen(),
    );
  }
}
