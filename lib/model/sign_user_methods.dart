import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUserMethods {
  //text editing controller
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign UP
  void signUserUp(BuildContext context) async {
    // Показываем крутилку загрузки
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try creating the user

    //проверяем совпадает ли пароль
    if (passwordController.text == confirmPasswordController.text) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // pop the loading circle
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // Если возникла ошибка, закрываем диалог и показываем сообщение об ошибке
        Navigator.pop(context); // Закрыть диалог загрузки
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Center(child: Text(e.message ?? 'An error occurred.')),
            );
          },
        );
      }
    } else {
      // pop the loading circle

      Navigator.pop(context);
      //ошибка
      showErrorMeassage('Passwords don\'t match!', context);
    }
  }

  //sign IN
  void signUserIn(BuildContext context) async {
    // Показываем крутилку загрузки
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle

      Navigator.pop(context);
      showErrorMeassage(e.code, context);
    }
  }

  //show error message
  void showErrorMeassage(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(message)),
        );
      },
    );
  }

  //sign OUT
  void signUserOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    emailController.clear();
    passwordController.clear();
    Navigator.pushNamed(context, '/');
  }
}
