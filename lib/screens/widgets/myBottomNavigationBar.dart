import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_translator_app/model/sign_user_methods.dart';

//нижняя навигационная панель
class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar({super.key});

  SignUserMethods signUserMethods = SignUserMethods();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: IconTheme(
        data: IconThemeData(
            size: 30, color: Theme.of(context).colorScheme.onPrimaryContainer),
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed('/');
                },
                icon: const Icon(Icons.translate)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).popAndPushNamed('/history');
                },
                icon: const Icon(Icons.library_books)),
            IconButton(
                onPressed: () {
                  signUserMethods.signUserOut(context);
                },
                icon: const Icon(Icons.logout)),
          ],
        ),
      ),
    );
  }
}
