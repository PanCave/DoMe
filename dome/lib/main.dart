import 'package:flutter/material.dart';
import 'package:dome/screens/home_screen.dart';

void main() {
  runApp(const DoMeApp());
}

class DoMeApp extends StatelessWidget {
  const DoMeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Do Me!',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const HomeScreen(title: 'Einfache ToDo-Liste'),
    );
  }
}