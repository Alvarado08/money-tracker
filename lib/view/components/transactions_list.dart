import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: const [
            ListTile(
              leading: Icon(Icons.attach_money, color: Colors.green),
              title: Text('Income'),
              subtitle: Text('Salary'),
              trailing: Text('\$100.00'),
            ),
            ListTile(
              leading: Icon(Icons.money_off, color: Colors.red),
              title: Text('Expense'),
              subtitle: Text('Groceries'),
              trailing: Text('-\$250.00'),
            ),
          ],
        ),
      ),
    );
  }
}
