import 'package:flutter/material.dart';

class RowInfo extends StatelessWidget {
  const RowInfo({Key? key, required this.title, required this.text})
      : super(key: key);

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            color: const Color(0xffefe8de),
            padding: const EdgeInsets.all(2),
            child: Text("▶ $title",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w800))),
        const Text(": ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        Text(text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
      ],
    );
  }
}
