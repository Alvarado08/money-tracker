import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTransactionBottomSheet extends StatefulWidget {
  const AddTransactionBottomSheet({super.key});

  @override
  State<AddTransactionBottomSheet> createState() =>
      _AddTransactionBottomSheetState();
}

class _AddTransactionBottomSheetState extends State<AddTransactionBottomSheet> {
  int? typeIndex = 1;

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
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {},
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
