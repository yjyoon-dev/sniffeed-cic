import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/model/empty_string.dart';
import 'package:sniffeed_content_image_creator/model/feed.dart';
import 'package:sniffeed_content_image_creator/model/nutrient.dart';
import 'package:sniffeed_content_image_creator/screen/components/row_info.dart';

class BaseInfo extends StatelessWidget {
  const BaseInfo({Key? key, required this.nutrient}) : super(key: key);

  final Nutrient nutrient;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (nutrient.weight != EMPTY)
          RowInfo(title: "제퓸 무게", text: nutrient.weight),
        if (nutrient.count != EMPTY) RowInfo(title: "개수", text: nutrient.count),
        if (nutrient.price != EMPTY)
          RowInfo(title: "제품 가격", text: nutrient.price),
        if (nutrient.pricePer != EMPTY)
          RowInfo(title: "100g 당 가격", text: nutrient.pricePer),
      ],
    );
  }
}
