import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/model/empty_string.dart';
import 'package:sniffeed_content_image_creator/model/feed.dart';
import 'package:sniffeed_content_image_creator/screen/components/row_info.dart';

class BaseInfo extends StatelessWidget {
  const BaseInfo({Key? key, required this.feed}) : super(key: key);

  final Feed feed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (feed.age != EMPTY) RowInfo(title: "적합 연령", text: feed.age),
        if (feed.weight != EMPTY) RowInfo(title: "제퓸 무게", text: feed.weight),
        if (feed.price != EMPTY) RowInfo(title: "제품 가격", text: feed.price),
        if (feed.pricePer != EMPTY)
          RowInfo(title: "100g 당 가격", text: feed.pricePer),
      ],
    );
  }
}
