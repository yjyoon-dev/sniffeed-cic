import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/model/empty_string.dart';
import 'package:sniffeed_content_image_creator/model/hay.dart';
import 'package:sniffeed_content_image_creator/screen/components/column_info.dart';
import 'package:sniffeed_content_image_creator/screen/components/content_title.dart';
import 'package:sniffeed_content_image_creator/screen/hay/components/base_info.dart';

class HayContent extends StatelessWidget {
  const HayContent({Key? key, required this.hay}) : super(key: key);

  final Hay hay;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1024,
      height: 1024,
      color: const Color(0xffbfa58c),
      child: Center(
          child: Stack(
        children: [
          Container(
              width: 984,
              height: 984,
              color: Colors.white,
              padding: const EdgeInsets.all(64),
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/images/background.png",
                      width: 500,
                      height: 500,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContentTitle(korean: hay.korean, english: hay.english),
                        BaseInfo(hay: hay),
                        if (hay.material != EMPTY)
                          ColumnInfo(title: "원재료", text: hay.material),
                        if (hay.feature != EMPTY)
                          ColumnInfo(title: "기능 및 특징", text: hay.feature),
                      ]),
                ],
              )),
        ],
      )),
    );
  }
}
