import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/model/sample/feed_info.dart';
import 'package:sniffeed_content_image_creator/screen/sample/generation/components/column_title.dart';
import 'package:sniffeed_content_image_creator/screen/sample/generation/components/common_spacer.dart';

class SodiumInfoComponent extends StatelessWidget {
  const SodiumInfoComponent({Key? key, required this.compareInfo})
      : super(key: key);

  final CompareInfo compareInfo;
  @override
  Widget build(BuildContext context) {
    var isSodium = compareInfo.type == CompareType.sodium;

    return Column(
      children: [
        Row(
          children: [
            ColumnTitle(text: (isSodium ? "나트륨" : "당분") + " 비교"),
            const SizedBox(width: 12),
            Text(
                "※ " +
                    (isSodium ? "육식" : "초식") +
                    "동물에게 " +
                    (isSodium ? "나트륨" : "당분") +
                    "은 중요한 체크사항이에요!",
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500))
          ],
        ),
        const CommonSpacer(),
        const CommonSpacer(),
        Container(
          decoration: const BoxDecoration(
              color: Color(0xffefe8de),
              borderRadius: BorderRadius.all(Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(3.5, 3.5))
              ]),
          padding: const EdgeInsets.all(6),
          child: Container(
            padding: const EdgeInsets.fromLTRB(48, 22, 48, 14),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(24)),
                border: Border.all(color: const Color(0xff573c11), width: 2.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildColumn("100g 당 " + (isSodium ? "Na" : "당분")),
                    const CommonSpacer(),
                    buildData(compareInfo.per100g),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildColumn("전체 " + (isSodium ? "Na" : "당") + " 평균"),
                    const CommonSpacer(),
                    buildData(compareInfo.totalAvg),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildColumn("전체 " + (isSodium ? "Na" : "당") + " 평균 g 차이"),
                    const CommonSpacer(),
                    buildData(compareInfo.totalAvgSub),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildColumn((isSodium ? "Na" : "당분") + " 함량의 정도"),
                    const CommonSpacer(),
                    buildData(compareInfo.contentDegree),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildColumn(String text) {
    return Text(text,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500));
  }

  Widget buildData(String text) {
    return Text(text,
        style: TextStyle(
            color: text.startsWith('-')
                ? Colors.red
                : (text.startsWith('+')
                    ? Colors.blue
                    : const Color(0xff573c11)),
            fontSize: 48,
            fontWeight: FontWeight.w700));
  }
}
