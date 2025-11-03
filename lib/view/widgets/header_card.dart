import 'package:flutter/material.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({
    super.key,
    required this.textTheme,
    required this.title,
    required this.amount,
    required this.icon,
  });

  final TextTheme textTheme;
  final String title;
  final double amount;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  SizedBox(width: 4),
                  Text(
                    title,
                    style: textTheme.titleSmall!.copyWith(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Text("\$ $amount", style: textTheme.titleLarge!),
            ],
          ),
        ),
      ),
    );
  }
}
