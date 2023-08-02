import 'package:flutter/material.dart';

class TextWidgetAll extends StatelessWidget {
  final String leftText;
  const TextWidgetAll({super.key, required this.leftText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: const TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Show All',
            style: TextStyle(
              fontSize: 17,
              color: Colors.purple.shade400,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
