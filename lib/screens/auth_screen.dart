import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_translator_app/screens/login_screen.dart';
import 'package:language_translator_app/screens/translator_screen.dart';

import 'login_or_register_screen.dart';

//проверяем залогинился ли пользователь или нет
//если нет - то LoginScreen
//если да, то TranslatorScreen

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //слушает изменение статуса аутентификатции
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Если пользователь аутентифицирован, возвращаем TranslatorScreen
            return TranslatorScreen();
          } else {
            // Если пользователь не аутентифицирован
            return LoginOrRegisterScreen();
          }
        },
      ),
    );
  }
}
