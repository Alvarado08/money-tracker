import 'package:flutter/material.dart';
import 'package:money_tracker/view/components/home_header.dart';
import 'package:money_tracker/view/components/transactions_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        bottom: false,
        child: Column(children: [HomeHeader(), TransactionsList()]),
      ),
    );
  }
}
