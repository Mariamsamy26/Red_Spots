import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Report {
  String id;
  String title;
  List description;
  DateTime timestamp;


  Report({
    this.id = '',
    required this.title,
    required this.description,
    required this.timestamp,
  });

  String get formattedTimestamp => DateFormat('dd MMM yyyy , hh:mm a').format(timestamp);

  Report.fromJson(Map<String, dynamic> data)
      : this(
    id: data['id'] ?? '',
    title: data['title'] ?? '',
    description: data['description'] ?? [],
    timestamp: (data['timestamp'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
