import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:language_translator_app/model/translation_history.dart';
import 'package:language_translator_app/screens/widgets/myAppBar.dart';
import 'package:language_translator_app/screens/widgets/myBottomNavigationBar.dart';
import 'package:provider/provider.dart';

import '../model/translationLogic.dart';
import '../provider/translationHistoryProvider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late TranslationLogic translationLogic;

  @override
  void initState() {
    super.initState();
    translationLogic = TranslationLogic(
      historyProvider: Provider.of<TranslationHistoryProvider>(context,
          listen: false), // Передаем экземпляр CalculationHistoryProvider
      updateStateCallback: () {
        setState(() {}); // Обновляем состояние виджета после перевода
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavigationBar(),
      appBar: MyAppBar(),
      //кнопка удаление истории
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Clear history'),
              content: const Text('Are you sure you want to clear translation history?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Provider.of<TranslationHistoryProvider>(
                        context, listen: false).clearHistory();
                    // Закрываем текущий экран и возвращаемся на предыдущий экран
                    Navigator.pop(context);
                    //показываем уведомление об удалении истории
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Translation history has been cleared!',textAlign: TextAlign.center,),
                        duration: const Duration(milliseconds: 1500),
                        margin: const EdgeInsets.all(25.0),
                        padding: const EdgeInsets.all(10.0),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    );
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Очистить историю при нажатии на кнопку
      //     Provider.of<TranslationHistoryProvider>(context, listen: false)
      //         .clearHistory();
      //   },
        child: const Icon(Icons.delete),
        backgroundColor: Theme.of(context).colorScheme.errorContainer,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endContained,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<TranslationHistory>>(
              //задаем функцию достать историю
              future: Provider.of<TranslationHistoryProvider>(context)
                  .getAllTranslationHistory(),
              //какой виджет показывать ---->
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data!.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: snapshot.data!.map((translationHistory) {
                        Container col = Container(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                    '${DateFormat('yyyy-MM-dd HH:mm').format(translationHistory.date)} '),
                                FloatingActionButton(
                                  mini: true,
                                  child: Text('X', style: TextStyle(fontWeight: FontWeight.bold),),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                  onPressed: () {
                                    translationLogic.deleteData(translationHistory);
                                    //показываем уведомление об удалении записи
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Record has been deleted!',textAlign: TextAlign.center,),
                                        duration: const Duration(milliseconds: 1500),
                                        //width: 380.0, // Width of the SnackBar.
                                        margin: const EdgeInsets.all(25.0),
                                        padding: const EdgeInsets.all(10.0),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                      ),
                                    );
                                    //Navigator.pop(context);
                                  },
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            ),
                            Text(
                              '${translationHistory.input} ',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '${translationHistory.output} ',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 2,
                                color: Colors.black12,
                              ),
                            )
                          ],
                        ));
                        return col;
                      }).toList(),
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(
                    heightFactor: 30,
                    child: Text('History is empty now'),
                  );
                } else {
                  return const Center(
                    heightFactor: 30,
                    child: Text('Loading...'),
                  );
                }
              }),
        ),
      ),
    );
  }
}
