import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_translator_app/screens/widgets/myBottomNavigationBar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavigationBar(),
      body: SafeArea(
        child: Center(
          child: Text('HistoryScreen coming soon'),
        ),
      ),

    );
  }
}
