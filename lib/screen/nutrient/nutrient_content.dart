import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/model/empty_string.dart';
import 'package:sniffeed_content_image_creator/model/feed.dart';
import 'package:sniffeed_content_image_creator/model/nutrient.dart';
import 'package:sniffeed_content_image_creator/screen/components/column_info.dart';
import 'package:sniffeed_content_image_creator/screen/components/content_title.dart';
import 'package:sniffeed_content_image_creator/screen/nutrient/components/base_info.dart';

class NutrientContent extends StatelessWidget {
  const NutrientContent({Key? key, required this.nutrient}) : super(key: key);

  final Nutrient nutrient;

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
                        ContentTitle(
                            korean: nutrient.korean, english: nutrient.english),
                        BaseInfo(nutrient: nutrient),
                        if (nutrient.amount != EMPTY + "-")
                          ColumnInfo(title: "급여량", text: nutrient.amount),
                        if (nutrient.material != EMPTY)
                          ColumnInfo(title: "원재료", text: nutrient.material),
                        if (nutrient.feature != EMPTY)
                          ColumnInfo(title: "기능 및 특징", text: nutrient.feature),
                        if (nutrient.ingredient != EMPTY)
                          ColumnInfo(title: "성분", text: nutrient.ingredient),
                      ]),
                ],
              )),
        ],
      )),
    );
  }
}
