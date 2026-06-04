import 'package:cloud_firestore/cloud_firestore.dart';

class JournelEntry {
  String id;
  String title;
  String description;
  DateTime date;

  JournelEntry({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory JournelEntry.fromMap(String id, Map<String, dynamic> map) {
    return JournelEntry(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      date: _convertToDateTime(map['date']),
    );
  }

  static DateTime _convertToDateTime(dynamic dataField) {
    if (dataField == null) {
      return DateTime.now();
    }
    if (dataField is DateTime) {
      return dataField;
    }
    if (dataField is Timestamp) {
      return dataField.toDate();
    }
    return DateTime.now();
  }
}
