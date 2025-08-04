import 'package:flutter/material.dart';
import 'package:mockup_v2/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

// Die Hauptanwendungsklasse.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mockup App V2',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
