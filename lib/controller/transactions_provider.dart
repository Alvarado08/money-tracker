import 'package:flutter/material.dart';
import 'package:money_tracker/model/transaction.dart';

class TransactionsProvider with ChangeNotifier {
  // underscore before variable makes it private
  final List<Transaction> _transactions = [
    Transaction(
      type: TransactionType.income,
      amount: 100.0,
      description: 'Salary',
    ),
    Transaction(
      type: TransactionType.expense,
      amount: 250.0,
      description: 'Groceries',
    ),
  ];

  List<Transaction> get transactions {
    return [..._transactions];
  }
  // Or using arrow function
  // List<Transaction> get transactions => _transactions;

  double getTotalIncome() {
    return _transactions
        .where((transaction) => transaction.type == TransactionType.income)
        .map((transaction) => transaction.amount)
        .fold(0, (sum, amount) => sum + amount);
  }

  double getTotalExpense() {
    return _transactions
        .where((transaction) => transaction.type == TransactionType.expense)
        .map((transaction) => transaction.amount)
        .fold(0, (sum, amount) => sum + amount);
  }

  double getBalance() {
    return getTotalIncome() - getTotalExpense();
  }

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }
}
