import 'package:flutter/material.dart';
import 'package:mockup_v2/screens/home_screen.dart';

// Die Hauptfunktion, der Einstiegspunkt der App.
void main() {
  runApp(const MyApp());
}

// MyApp ist das Root-Widget deiner App.
// Es definiert das Grundthema und den Startbildschirm.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp ist ein praktisches Widget, das eine App im Material Design
    // kapselt. Es stellt viele nützliche Funktionen bereit.
    return MaterialApp(
      title: 'Meine Flutter App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Hier wird der HomeScreen als erster Bildschirm der App festgelegt.
      home: const HomeScreen(),
    );
  }
}
