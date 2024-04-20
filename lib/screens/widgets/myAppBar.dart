import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("My Translator",
      style: TextStyle(
        fontWeight: FontWeight.bold
      ),),
      centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
    );
  }
}