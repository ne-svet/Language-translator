import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:language_translator_app/controllers/persistance_controller.dart';
import 'package:language_translator_app/model/translation_history.dart';

import '../firebase_options.dart';

class FirestoreController implements PersistenceController {
  late FirebaseFirestore db;

  //удаляем объект по его ID
  @override
  Future<void> deleteData(TranslationHistory translationHistory) async {
    await init();
    // Получаем идентификатор документа, который нужно удалить
    String documentId = translationHistory.id;

    // Удаляем документ из коллекции 'translationHistory' по его идентификатору
    await db.collection('translationHistory').doc(documentId).delete();
  }

  //получаем список всех TranslationHistory из Firebase
  @override
  Future<List<TranslationHistory>> getAllData() async {
    await init();
    //получаем документы из коллекции translationHistory в Map формате
    QuerySnapshot snapshot = await db
        .collection('translationHistory')
        //сортируем по дате
        .orderBy('date', descending: true)
        .get();
    //обрабатываем snapshot,
    // из каждого документа docs делаем translationHistory
    //получаем список и возвращаем history
    List<TranslationHistory> translationHistory = snapshot.docs.map((doc) {
      // Получаем данные документа в виде Map
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      // Создаем объект TranslationHistory, передавая данные и идентификатор документа
      return TranslationHistory.fromMap(data, doc.id);
    }).toList();
    return translationHistory;
  }

  @override
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    //инициализируется БД (следуем инструкции)
    db = FirebaseFirestore.instance;
  }

  @override
  Future<void> saveData(TranslationHistory translationHistory) async {
    await init();
    try {
      // добавляем в историю docRef
      DocumentReference docRef = await db
          .collection('translationHistory')
          .add(translationHistory.toMap());

      // автоматически сгенерированный id
      translationHistory.id = docRef.id;
    } catch (e) {
      print('Error saving translation history: $e');
      throw e;
    }
  }

  @override
  Future<void> clearHistory() async{
    await init();
    //получаем базу для удаления
    QuerySnapshot snapshot = await db.collection('translationHistory')
        .get();
    // Проверяем, есть ли документы для удаления
    if (snapshot.docs.isNotEmpty) {
      // Используем цикл для удаления каждого документа
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } else {
      print('Nothing to delete');
    }
  }
}
