import 'package:flutter/material.dart';

class ColumnInfo extends StatelessWidget {
  const ColumnInfo({Key? key, required this.title, required this.text})
      : super(key: key);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            color: const Color(0xffefe8de),
            padding: const EdgeInsets.all(2),
            child: Text("▶ $title",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w800))),
        Text(text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
