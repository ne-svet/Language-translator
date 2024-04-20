import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:language_translator_app/provider/translationHistoryProvider.dart';
import 'package:language_translator_app/screens/history_screen.dart';
import 'package:language_translator_app/screens/translator_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async{
  //аутентификация
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          //создаем и предоставляем объект CalculationHistoryModel, который будет использоваться во всем приложении.
          create: (context) => TranslationHistoryProvider(),

        ),
      ],
        child: MyApp(),
    ),
  );
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
      initialRoute: '/', // Устанавливаем начальный маршрут
      //экраны
      routes: {
        '/' : (context) => TranslatorScreen(),
        '/history' : (context) => HistoryScreen(),
      },
    );
  }
}



