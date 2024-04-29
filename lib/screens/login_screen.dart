import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:language_translator_app/model/sign_user_methods.dart';
import 'package:language_translator_app/screens/auth_screen.dart';
import 'package:language_translator_app/screens/widgets/my_textfield.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;

  LoginScreen({super.key, required this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SignUserMethods signUserMethods = SignUserMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                //приложение
                const Icon(
                  Icons.translate,
                  size: 100,
                ),

                const SizedBox(
                  height: 50,
                ),

                //приветствие
                Text(
                  'Welcome back, you\'ve been missed!',
                  style: TextStyle(color: Colors.grey[700]!, fontSize: 16),
                ),
                const SizedBox(
                  height: 25,
                ),

                //email
                MyTextField(
                  controller: signUserMethods.emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(
                  height: 10,
                ),

                //password
                MyTextField(
                  controller: signUserMethods.passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(
                  height: 30,
                ),

                // //forgot password
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         'Forgot Password?',
                //         style:
                //             TextStyle(color: Colors.grey[700]!, fontSize: 16),
                //       ),
                //     ],
                //   ),
                // ),

                const SizedBox(
                  height: 25,
                ),

                //sign in button
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  child: ElevatedButton(
                    onPressed: () {
                      signUserMethods.signUserIn(context);
                    },
                    child: const Text("Sign In"),
                    style: ElevatedButton.styleFrom(
                      minimumSize:
                          Size(double.infinity, 48.0), // Задает ширину кнопки
                    ),
                  ),
                ),

                const SizedBox(
                  height: 80,
                ),

                //регистрация
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]!, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'Register now',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
