import 'package:flutter/cupertino.dart';
import 'package:language_translator_app/model/translation_history.dart';
import 'package:translator/translator.dart';

import '../provider/translationHistoryProvider.dart';
import 'languages.dart';

class TranslationLogic {
  late LanguageLabel selectedLangFrom;
  late LanguageLabel selectedLangTo;
  String output = '';

  // Добавляем переменную для хранения экземпляра CalculationHistoryProvider
  TranslationHistoryProvider historyProvider;

  // обновление состояния на экране
  VoidCallback updateStateCallback;

  //конструктор
  TranslationLogic({
    required this.historyProvider,
    required this.updateStateCallback,
    //изначальные значения языков
    LanguageLabel selectedLangFrom = LanguageLabel.russian,
    LanguageLabel selectedLangTo = LanguageLabel.english,
  })  : this.selectedLangFrom = selectedLangFrom,
        this.selectedLangTo = selectedLangTo;

  // Метод для установки колбэка обновления состояния
  void setUpdateStateCallback(VoidCallback callback) {
    updateStateCallback = callback;
  }

// функция перевода
  void translate(String input) async {
    // Если выбранные языки одинаковые, ничего не делаем
    if (selectedLangFrom == selectedLangTo) {
      return;
    }
    if (input == '') {
      output = '';
      updateStateCallback();
      return;
    }

    GoogleTranslator translator = GoogleTranslator();
    var translationRes = await translator.translate(input,
        from: selectedLangFrom.code, to: selectedLangTo.code);
    output = translationRes.text;
    updateStateCallback(); // Вызов колбэка для обновления интерфейса
  }

  //направление перевода
  void changeLanguage() {
    final tempLang = selectedLangFrom;
    selectedLangFrom = selectedLangTo;
    selectedLangTo = tempLang;
    updateStateCallback();
  }

  //переводим output обратно
  void changeInput(String txt) {
    translate(txt);
  }

  void saveData(String inputText) {
    // Если ввод или перевод пустые, не сохраняем
    if (inputText.isEmpty || output.isEmpty) {
      return;
    }
    // Добавляем расчет в историю, создав объект TranslationHistory
    historyProvider.addTranslationHistory(TranslationHistory(
      input: inputText,
      output: output,
      date: DateTime.now(),
    ));
    updateStateCallback();
  }

  void deleteData(TranslationHistory th) {
    historyProvider.deleteData(th).then((_) {
      updateStateCallback(); // Обновляем состояние после удаления
    }).catchError((error) {
      print("Error deleting translation history: $error");
    });
  }
}
