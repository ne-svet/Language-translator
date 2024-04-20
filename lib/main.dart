import 'package:flutter/material.dart';
import 'package:language_translator_app/screens/history_screen.dart';
import 'package:language_translator_app/screens/translator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Language translator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        useMaterial3: true,
      ),
      //экраны
      routes: {
        '/' : (context) => TranslatorScreen(),
        '/history' : (context) => HistoryScreen(),
      },
    );
  }
}



