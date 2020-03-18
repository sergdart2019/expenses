import 'package:flutter/material.dart';

class Transactions with ChangeNotifier {
  List<Transaction> transactions = [
    Transaction(
        title: 'Groceries',
        amount: 28.00,
        date: DateTime.now().subtract(Duration(days: 6))),
    Transaction(
        title: 'Groceries',
        amount: 720.00,
        date: DateTime.now().subtract(Duration(days: 5))),
    Transaction(
        title: 'Groceries',
        amount: 900.00,
        date: DateTime.now().subtract(Duration(days: 4))),
    Transaction(
        title: 'Groceries',
        amount: 1120.00,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        title: 'Groceries',
        amount: 50.17,
        date: DateTime.now().subtract(Duration(days: 2))),
    Transaction(
        title: 'New shoes',
        amount: 150.22,
        date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(title: 'New shoes', amount: 169.99, date: DateTime.now()),
    Transaction(title: 'Weekly groceries', amount: 75.67, date: DateTime.now())
  ];

  bool addTransaction({String title, String amount, DateTime date}) {
    if (title == null || amount == null || date == null) {
      return false;
    }
    transactions.add(
      Transaction(
        title: title,
        amount: double.parse(amount),
        date: date,
      ),
    );
    // Sort by  date
    transactions.sort((transaction1, transaction2) {
      return transaction1.date.compareTo(transaction2.date);
    });
    notifyListeners();
    return true;
  }

  void deleteTransaction(int index) {
    transactions.removeAt(index);
    notifyListeners();
  }
}

class Transaction {
  final String title;
  final double amount;
  final DateTime date;

  Transaction({
    this.title,
    this.amount,
    this.date,
  });
}
