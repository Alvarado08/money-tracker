import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/controller/transactions_provider.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:provider/provider.dart';

class AddTransactionBottomSheet extends StatefulWidget {
  const AddTransactionBottomSheet({super.key});

  @override
  State<AddTransactionBottomSheet> createState() =>
      _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState extends State<AddTransactionBottomSheet> {
  int? typeIndex = 1;

  TransactionType type = TransactionType.expense;
  double amount = 0;
  String description = "";

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 600,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Add Transaction',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            CupertinoSlidingSegmentedControl(
              groupValue: typeIndex,
              children: const {0: Text("Income"), 1: Text("Expense")},
              onValueChanged: (value) {
                setState(() {
                  typeIndex = value;
                  value == 0
                      ? type = TransactionType.income
                      : type = TransactionType.expense;
                });
              },
            ),
            SizedBox(height: 20),
            Text(
              "AMOUNT",
              style: textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              inputFormatters: [
                CurrencyTextInputFormatter.currency(locale: 'en', symbol: '\$'),
              ],
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration.collapsed(
                hintText: "\$0.00",
                hintStyle: TextStyle(color: Colors.grey.shade400),
              ),
              autofocus: true,
              onChanged: (value) {
                final valueWithoutSymbol = value
                    .replaceAll('\$', '')
                    .replaceAll(',', '');
                if (valueWithoutSymbol.isNotEmpty) {
                  amount = double.parse(valueWithoutSymbol);
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              "DESCRIPTION",
              style: textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration.collapsed(
                hintText: "Enter description",
                hintStyle: TextStyle(color: Colors.grey.shade400),
              ),
              autofocus: true,
              onChanged: (value) {
                description = value;
              },
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  final transaction = Transaction(
                    type: type,
                    amount: type == TransactionType.expense ? -amount : amount,
                    description: description,
                  );
                  Provider.of<TransactionsProvider>(
                    context,
                    listen: false,
                  ).addTransaction(transaction);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "ADD",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
