import 'package:cloud_firestore/cloud_firestore.dart';

class TranslationHistory {
  // Поле для хранения идентификатора документа Firestore
  final String id;
  final String input;
  final String output;
  final Timestamp date;
  final String userId;

  TranslationHistory(
      {this.id = '',
      required this.userId,
      required this.input,
      required this.output,
      required this.date});

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "input": input,
      "output": output,
      "date": date,
    };
  }

//преобразование данных для загрузки из БД
//пишем функцию fromMap
  factory TranslationHistory.fromMap(
      Map<String, dynamic> map, String documentId) {
    TranslationHistory th = TranslationHistory(
        id: documentId,
        userId: map['userId'],
        input: map['input'],
        output: map['output'],
        date: map['date']);
    return th;
  }
}
