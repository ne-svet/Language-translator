import 'package:flutter/cupertino.dart';
import 'package:translator/translator.dart';

import 'languages.dart';

class TranslationLogic {
  late LanguageLabel selectedLangFrom;
  late LanguageLabel selectedLangTo;
  String output = '';


  // обновление состояния на экране
  VoidCallback updateStateCallback;

  //конструктор
  TranslationLogic({
    //required this.historyProvider,
    required this.updateStateCallback,
    //изначальные значения языков
    LanguageLabel selectedLangFrom = LanguageLabel.english,
    LanguageLabel selectedLangTo = LanguageLabel.russian,
  }) : this.selectedLangFrom = selectedLangFrom,
        this.selectedLangTo = selectedLangTo;

  // Метод для установки колбэка обновления состояния
  void setUpdateStateCallback(VoidCallback callback) {
    updateStateCallback = callback;
  }

// функция перевода
  void translate(String input) async {
    // Если выбранные языки одинаковые, ничего не делаем
    if(selectedLangFrom == selectedLangTo) {
      return;
    }
    if(input == '') {
      output = '';
      updateStateCallback();
      return;
    }

    GoogleTranslator translator = GoogleTranslator();
    var translationRes = await translator.translate(
        input,
        from: selectedLangFrom.code,
        to:selectedLangTo.code);
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

  }

