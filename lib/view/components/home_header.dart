import 'package:flutter/material.dart';
import 'package:money_tracker/controller/transactions_provider.dart';
import 'package:money_tracker/view/widgets/header_card.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final provider = Provider.of<TransactionsProvider>(context);
    final balance = provider.getBalance();
    final totalIncome = provider.getTotalIncome();
    final totalExpense = provider.getTotalExpense();
    final formattedBalance = balance < 0
        ? "-\$${balance.abs().toStringAsFixed(2)}"
        : "\$${balance.toStringAsFixed(2)}";

    return SizedBox(
      width: double.infinity, // Full width of the parent
      child: Column(
        children: [
          Text(
            "MONEY TRACKER",
            style: textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Balance",
            style: textTheme.bodySmall!.copyWith(color: Colors.white),
          ),
          Text(
            // "\$1000.00",
            formattedBalance,
            style: textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HeaderCard(
                  textTheme: textTheme,
                  title: "Incomes",
                  amount: totalIncome,
                  icon: Icon(
                    Icons.attach_money,
                    color: Colors.green.shade700,
                    size: 16,
                  ),
                ),
                HeaderCard(
                  textTheme: textTheme,
                  title: "Expenses",
                  amount: totalExpense,
                  icon: Icon(
                    Icons.money_off,
                    color: Colors.red.shade700,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
