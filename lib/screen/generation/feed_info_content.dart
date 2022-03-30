import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/model/feed_info.dart';
import 'package:sniffeed_content_image_creator/screen/generation/components/additional_info.dart';
import 'package:sniffeed_content_image_creator/screen/generation/components/name_info.dart';
import 'package:sniffeed_content_image_creator/screen/generation/components/ingredient_table.dart';
import 'package:sniffeed_content_image_creator/screen/generation/components/sodium_info.dart';

class FeedInfoContent extends StatelessWidget {
  const FeedInfoContent({Key? key, required this.feedInfo}) : super(key: key);

  final FeedInfo feedInfo;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1024,
      height: 1024,
      color: const Color(0xffbfa58c),
      child: Center(
        child: Container(
          width: 984,
          height: 984,
          color: Colors.white,
          padding: const EdgeInsets.all(64),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NameComponent(
                    koreanName: feedInfo.koreanName,
                    englishName: feedInfo.englishName),
                AdditionalInfoComponent(
                    additionalInfo: feedInfo.additionalInfos[0]),
                AdditionalInfoComponent(
                    additionalInfo: feedInfo.additionalInfos[1]),
                AdditionalInfoComponent(
                    additionalInfo: feedInfo.additionalInfos[2]),
                IngredientTableComponent(
                    ingredientTable: feedInfo.ingredientTable),
                SodiumInfoComponent(sodiumInfo: feedInfo.sodiumInfo)
              ]),
        ),
      ),
    );
  }
}
