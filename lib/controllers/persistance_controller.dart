

//абстрактный класс, он же интерфейс.
// Которые будем использовать в контроллере
import 'package:language_translator_app/model/translation_history.dart';

abstract class PersistenceController {

  //соединение с БД
  Future<void> init();

  //получить все данные из объектов TranslationHistory
  Future<List<TranslationHistory>> getAllData();

  //сохранение данных
  Future<void> saveData(TranslationHistory translationHistory);

  //удаление конкретной записи по id
  Future<void> deleteData(TranslationHistory translationHistory);

  //очистить историю
  Future<void> clearHistory();

}
