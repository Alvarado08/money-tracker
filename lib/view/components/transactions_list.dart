import 'package:flutter/material.dart';
import 'package:money_tracker/controller/transactions_provider.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:provider/provider.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    final transactions = Provider.of<TransactionsProvider>(
      context,
    ).transactions;

    return Expanded(
      child: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            final type = transaction.type == TransactionType.income
                ? "Income"
                : "Expense";
            return ListTile(
              leading: Icon(
                type == "Income" ? Icons.attach_money : Icons.money_off,
                color: type == "Income" ? Colors.green : Colors.red,
              ),
              title: Text(transaction.description),
              subtitle: Text(type),
              trailing: Text(
                type == "Income"
                    ? '+\$${transaction.amount.toStringAsFixed(2)}'
                    : '-\$${transaction.amount.toStringAsFixed(2)}',
              ),
            );
          },
        ),
        // child: ListView(
        //   children: const [
        //     ListTile(
        //       leading: Icon(Icons.attach_money, color: Colors.green),
        //       title: Text('Income'),
        //       subtitle: Text('Salary'),
        //       trailing: Text('\$100.00'),
        //     ),
        //     ListTile(
        //       leading: Icon(Icons.money_off, color: Colors.red),
        //       title: Text('Expense'),
        //       subtitle: Text('Groceries'),
        //       trailing: Text('-\$250.00'),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
