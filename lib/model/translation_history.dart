class TranslationHistory {
  // Поле для хранения идентификатора документа Firestore
  late String id;
  final String input;
  final String output;
  final DateTime date;

  TranslationHistory(
      {required this.input, required this.output, required this.date});

  Map<String, Object> toMap() {
    return {
      "input": input,
      "output": output,
      "date": date.toString(),
    };
  }

//преобразование данных для загрузки из БД
//пишем функцию fromMap
  factory TranslationHistory.fromMap(
      Map<String, dynamic> map, String documentId) {
    TranslationHistory th = TranslationHistory(
      input: map['input'],
      output: map['output'],
      date: DateTime.parse(map['date']),
    )..id = documentId; // Устанавливаем идентификатор из Firestore;
    return th;
  }
}
