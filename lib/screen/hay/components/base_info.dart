import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/model/empty_string.dart';
import 'package:sniffeed_content_image_creator/model/hay.dart';
import 'package:sniffeed_content_image_creator/screen/components/row_info.dart';

class BaseInfo extends StatelessWidget {
  const BaseInfo({Key? key, required this.hay}) : super(key: key);

  final Hay hay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (hay.weight != EMPTY) RowInfo(title: "제퓸 무게", text: hay.weight),
        if (hay.price != EMPTY) RowInfo(title: "제품 가격", text: hay.price),
        if (hay.pricePer != EMPTY)
          RowInfo(title: "100g 당 가격", text: hay.pricePer),
      ],
    );
  }
}
