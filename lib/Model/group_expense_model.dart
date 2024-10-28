import 'package:cloud_firestore/cloud_firestore.dart';

class GroupExpenseModal {
  String title, amount, userEmail, userAmount;
  Timestamp timestamp;
  List<UserExpenseModal> userExpense;

  GroupExpenseModal({
    required this.title,
    required this.amount,
    required this.userEmail,
    required this.timestamp,
    required this.userExpense,
    required this.userAmount,
  });

  factory GroupExpenseModal.fromData(Map<String, dynamic> json) {
    return GroupExpenseModal(
      title: json['title'],
      amount: json['amount'],
      userEmail: json['userEmail'],
      timestamp: json['timestamp'],
      userAmount: json['userAmount'],
      userExpense: (json['userExpense'] as List)
          .map((e) => UserExpenseModal.fromData(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> modalToMap() {
    return {
      'title': title,
      'amount': amount,
      'userEmail': userEmail,
      'timestamp': timestamp,
      'userAmount':userAmount,
      'userExpense': userExpense.map((e) => e.modalToMap()).toList(),
    };
  }
}

class UserExpenseModal {
  String amount, email;

  UserExpenseModal({
    required this.amount,
    required this.email,
  });

  factory UserExpenseModal.fromData(Map<String, dynamic> json) {
    return UserExpenseModal(
      amount: json['amount'],
      email: json['email'],
    );
  }

  Map<String, dynamic> modalToMap() {
    return {
      'amount': amount,
      'email': email,
    };
  }
}
