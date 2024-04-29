import 'package:flutter/material.dart';
import 'package:language_translator_app/model/sign_user_methods.dart';
import 'package:language_translator_app/screens/login_screen.dart';
import 'package:language_translator_app/screens/register_screen.dart';

class LoginOrRegisterScreen extends StatefulWidget {
  LoginOrRegisterScreen({super.key});

  SignUserMethods signUserMethods = SignUserMethods();

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  //
  bool showLoginScreen = true;

  //переключатель между страницей логина и регистрацией
  void toogleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(onTap: toogleScreens);
    } else {
      return RegisterScreen(
        onTap: toogleScreens,
      );
    }
  }
}
