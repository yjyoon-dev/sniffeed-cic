import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/model/feed_info.dart';
import 'package:sniffeed_content_image_creator/screen/generation/components/column_title.dart';
import 'package:sniffeed_content_image_creator/screen/generation/components/common_spacer.dart';

class SodiumInfoComponent extends StatelessWidget {
  const SodiumInfoComponent({Key? key, required this.sodiumInfo})
      : super(key: key);

  final SodiumInfo sodiumInfo;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            ColumnTitle(text: "나트륨 비교"),
            SizedBox(width: 12),
            Text("※ 육식동물에게 나트륨은 중요한 체크사항이에요!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500))
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
                    buildColumn("100g 당 Na"),
                    const CommonSpacer(),
                    buildData(sodiumInfo.per100g),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildColumn("전체 Na 평균"),
                    const CommonSpacer(),
                    buildData(sodiumInfo.totalAvg),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildColumn("전체 Na 평균 g 차이"),
                    const CommonSpacer(),
                    buildData(sodiumInfo.totalAvgSub),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildColumn("Na 함량의 정도"),
                    const CommonSpacer(),
                    buildData(sodiumInfo.contentDegree),
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
