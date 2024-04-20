import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//нижняя навигационная панель
class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: IconTheme(
        data: IconThemeData(
          size: 30,
            color: Theme.of(context).colorScheme.onPrimaryContainer
        ),
        child: Row(
          children: <Widget>[
            IconButton(
                onPressed: (){
                  Navigator.of(context).popAndPushNamed('/');
                },
                icon: const Icon(Icons.translate)),
            IconButton(
                onPressed: (){
                  Navigator.of(context).popAndPushNamed('/history');
                },
                icon: const Icon(Icons.library_books)),


          ],
        ),
      ),

    );
  }
}
