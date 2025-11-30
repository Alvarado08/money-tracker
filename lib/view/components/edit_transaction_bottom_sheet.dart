import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_tracker/controller/transactions_provider.dart';
import 'package:money_tracker/model/transaction.dart';
import 'package:provider/provider.dart';

class EditTransactionBottomSheet extends StatefulWidget {
  const EditTransactionBottomSheet({super.key, required this.oldTransaction});

  final Transaction oldTransaction;

  @override
  State<EditTransactionBottomSheet> createState() =>
      _EditTransactionBottomSheetState();
}

class _EditTransactionBottomSheetState
    extends State<EditTransactionBottomSheet> {
  int? typeIndex;
  late TransactionType type;
  late double amount = 0;
  late String description;

  @override
  void initState() {
    super.initState();
    type = widget.oldTransaction.type;
    typeIndex = (type == TransactionType.income) ? 0 : 1;
    amount = widget.oldTransaction.amount.abs();
    description = widget.oldTransaction.description;
  }

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
              'Edit Transaction',
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
            const SizedBox(height: 20),
            Text(
              "AMOUNT",
              style: textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: TextEditingController(
                text: "\$${amount.toStringAsFixed(2)}",
              ),
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
              controller: TextEditingController(text: description),
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
                  final newTransaction = Transaction(
                    type: type,
                    amount: type == TransactionType.expense ? -amount : amount,
                    description: description,
                  );
                  Provider.of<TransactionsProvider>(
                    context,
                    listen: false,
                  ).updateTransaction(widget.oldTransaction, newTransaction);
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "UPDATE",
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
