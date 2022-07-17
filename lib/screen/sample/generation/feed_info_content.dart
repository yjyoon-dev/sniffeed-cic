import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/model/sample/feed_info.dart';
import 'package:sniffeed_content_image_creator/screen/sample/generation/components/additional_info.dart';
import 'package:sniffeed_content_image_creator/screen/sample/generation/components/name_info.dart';
import 'package:sniffeed_content_image_creator/screen/sample/generation/components/ingredient_table.dart';
import 'package:sniffeed_content_image_creator/screen/sample/generation/components/compare_info.dart';

class SampleFeedInfoContent extends StatelessWidget {
  const SampleFeedInfoContent({Key? key, required this.feedInfo})
      : super(key: key);

  final SampleFeedInfo feedInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1024,
      height: 1024,
      color: const Color(0xffbfa58c),
      child: Center(
          child: Stack(
        children: [
          Image.asset("assets/images/background.png"),
          Container(
            width: 984,
            height: 984,
            color: Colors.white,
            padding: const EdgeInsets.all(64),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameComponent(
                      koreanName: feedInfo.korean,
                      englishName: feedInfo.english),
                  AdditionalInfoComponent(
                      additionalInfo: feedInfo.additionalInfos[0]),
                  AdditionalInfoComponent(
                      additionalInfo: feedInfo.additionalInfos[1]),
                  AdditionalInfoComponent(
                      additionalInfo: feedInfo.additionalInfos[2]),
                  IngredientTableComponent(
                      ingredientTable: feedInfo.ingredientTable),
                  SodiumInfoComponent(compareInfo: feedInfo.compareInfo)
                ]),
          ),
        ],
      )),
    );
  }
}
