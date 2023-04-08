import 'package:flutter/material.dart';
import 'package:rick_and_morty_bloc/ui/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and morty',
      theme: ThemeData(brightness: Brightness.light,
      primaryColor: Colors.black,
      fontFamily: 'Georgia',
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      home:  HomePage(title: 'Rick and Morty'),
    );
  }
}

