import 'package:flutter/material.dart';
import 'package:language_translator_app/model/languages.dart';
import 'package:language_translator_app/provider/translationHistoryProvider.dart';
import 'package:language_translator_app/screens/widgets/myAppBar.dart';
import 'package:language_translator_app/screens/widgets/myBottomNavigationBar.dart';
import 'package:provider/provider.dart';
import '../model/translationLogic.dart';

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  late TranslationLogic translationLogic;

  //контроллер введенного текста
  TextEditingController languageController = TextEditingController();

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    translationLogic = TranslationLogic(
      historyProvider: Provider.of<TranslationHistoryProvider>(context,
          listen: false), // Передаем экземпляр CalculationHistoryProvider
      updateStateCallback: () {
        setState(() {}); // Обновляем состояние виджета после перевода
      },
    );
  }

  @override
  void dispose() {
    languageController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTapOutside() {
    if (_focusNode.hasFocus) {
      _focusNode.unfocus(); // Снимаем фокус с текущего элемента управления
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTapOutside,
      behavior: HitTestBehavior.translucent, // Обработка тапов внутри и снаружи виджета
      child: Scaffold(
        appBar: const MyAppBar(),
        bottomNavigationBar: const MyBottomNavigationBar(),
        //кнопка добавления в историю
        floatingActionButton: FloatingActionButton(
          //нажатие на кнопку
          onPressed: () {
            // Вызываем метод сохранения данных из translationLogic
            translationLogic.saveData(languageController.text);

            //показываем уведомление о сохранении
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Translation has been saved!',textAlign: TextAlign.center,),
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
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endContained,

        //экран
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              //содержимое колонки
              children: [
                // 1 - пустой блок
                const SizedBox(
                  height: 20,
                ),
      
                // 2 - выбор языка
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //меню выборя языка FROM
                    Expanded(
                      child: DropdownMenu<LanguageLabel>(
                        initialSelection: translationLogic.selectedLangFrom,
                        label: const Text('From'),
                        onSelected: (LanguageLabel? newValue) {
                          setState(() {
                            translationLogic.selectedLangFrom = newValue!;
                          });
                        },
                        dropdownMenuEntries:
                            //мапим данные языков для меню
                            LanguageLabel.values
                                .map<DropdownMenuEntry<LanguageLabel>>(
                                    (LanguageLabel language) {
                          return DropdownMenuEntry<LanguageLabel>(
                            value: language,
                            label: language.label,
                          );
                        }).toList(),
                      ),
                    ),
      
                    //изменение направления перевода
                    IconButton(
                        onPressed: () {
                          // Вызываем изменение направления перевода
                          translationLogic.changeLanguage();
                          // обновляем текстовое поле контроллера ввода
                          languageController.text = translationLogic.output;
                          // вызываем изменение ввода с новым переводом
                          translationLogic.changeInput(translationLogic.output);
                        },
                        icon: const Icon(Icons.cached_rounded)),
      
                    //меню выборя языка TO
                    Expanded(
                      child: DropdownMenu<LanguageLabel>(
                        initialSelection: translationLogic.selectedLangTo,
                        label: const Text('To'),
                        onSelected: (LanguageLabel? newValue) {
                          setState(() {
                            translationLogic.selectedLangTo = newValue!;
                          });
                        },
                        dropdownMenuEntries: LanguageLabel.values
                            .map<DropdownMenuEntry<LanguageLabel>>(
                                (LanguageLabel language) {
                          return DropdownMenuEntry<LanguageLabel>(
                            value: language,
                            label: language.label,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
      
                // 3 - пустой блок
                const SizedBox(
                  height: 20,
                ),
      
                // 4 - поле для ввода текста
                SingleChildScrollView(
                  child: TextFormField(
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Type your text here',
                    ),
                    controller: languageController,
                    focusNode: _focusNode,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the text to translate';
                      }
                      return null;
                    },
                  ),
                ),
      
                //5 - кнопка перевод
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      translationLogic.translate(languageController.text);
                    },
                    child: const Text("Translate"),
                    // style: ElevatedButton.styleFrom(
                    //   minimumSize: Size(double.infinity, 48.0), // Задает ширину кнопки
                    // ),
                  ),
                ),
                //6 - перевод
                Container(
                  width: double.infinity,
                  // Занимает ширину колонки
                  // decoration: BoxDecoration(
                  //     color:
                  //     translationLogic.output.isEmpty?
                  //     Colors.white
                  //   : Theme.of(context).colorScheme.secondaryContainer, // Задаем цвет фона
                  //
                  //   borderRadius: BorderRadius.circular(8.0), // Закругляем углы
                  // ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    // Прокручивание по горизонтали
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      // Отступы внутри контейнера
                      child: Text(
                        translationLogic.output,
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
