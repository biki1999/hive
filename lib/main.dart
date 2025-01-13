import 'package:flutter/material.dart';
import 'package:hive_blog_app/screens/post_screen.dart';

void main() {
  runApp(const HiveBlogApp());
}

class HiveBlogApp extends StatelessWidget {
  const HiveBlogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive Blog App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
