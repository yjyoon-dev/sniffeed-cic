import 'package:flutter/material.dart';

class ContentTitle extends StatelessWidget {
  const ContentTitle({Key? key, required this.korean, required this.english})
      : super(key: key);

  final String korean;
  final String english;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Stack(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Container(color: Color(0xffefe8de), height: 25)),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(korean,
                style:
                    const TextStyle(fontSize: 27, fontWeight: FontWeight.w700)),
            Text(english,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
          ]),
        ],
      ),
    );
  }
}
