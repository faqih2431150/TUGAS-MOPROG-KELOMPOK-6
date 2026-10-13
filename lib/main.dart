import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const EcoGridApp());

class EcoGridApp extends StatelessWidget {
  const EcoGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoGrid Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF2F7F3),
      ),
      home: const HomeScreen(),
    );
  }
} 