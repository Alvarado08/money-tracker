import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity, // Full width of the parent
      color: Colors.grey,
      child: Text("This is the Home Header"),
    );
  }
}
