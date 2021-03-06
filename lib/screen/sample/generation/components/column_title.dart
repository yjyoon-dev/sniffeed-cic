import 'package:flutter/material.dart';

class ColumnTitle extends StatelessWidget {
  const ColumnTitle({Key? key, required this.text}) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xffefe8de),
        padding: const EdgeInsets.all(8),
        child: Text("▶ $text",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500)));
  }
}
