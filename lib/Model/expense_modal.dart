import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModal {
  String title, amount;
  Timestamp timestamp;

  ExpenseModal({
    required this.title,
    required this.amount,
    required this.timestamp,
  });

  factory ExpenseModal.fromData(Map json) {
    return ExpenseModal(
      title: json['title'],
      amount: json['amount'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> modalToMap() {
    return {
      'title': title,
      'amount': amount,
      'timestamp': timestamp,
    };
  }
}