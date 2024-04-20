import 'package:flutter/cupertino.dart';
import 'package:language_translator_app/controllers/firestore_controller.dart';
import 'package:language_translator_app/controllers/persistance_controller.dart';
import 'package:language_translator_app/model/translation_history.dart';

class TranslationHistoryProvider extends ChangeNotifier {

  PersistenceController persistenceController = FirestoreController();
  //  добавляет новые записи в историю
  Future<void> addTranslationHistory(TranslationHistory th) async{

    await persistenceController.saveData(th);
    notifyListeners(); //оповещаем слушателей, когда история обновляется
  }

  //получение данных
  Future<List<TranslationHistory>> getAllTranslationHistory() async{
    return persistenceController.getAllData();
  }

  //удаляем историю
  Future<void> clearHistory() async{
  await persistenceController.clearHistory();
    notifyListeners();
  }

  //удаляем конкретную запись
  Future<void> deleteData(TranslationHistory th) async{
    await persistenceController.deleteData(th);
    notifyListeners();
  }
}