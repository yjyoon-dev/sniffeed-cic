import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/model/sample/feed_info.dart';
import 'package:sniffeed_content_image_creator/screen/sample/generation/components/column_title.dart';
import 'package:sniffeed_content_image_creator/screen/sample/generation/components/common_spacer.dart';

class AdditionalInfoComponent extends StatelessWidget {
  const AdditionalInfoComponent({Key? key, required this.additionalInfo})
      : super(key: key);

  final AdditionalInfo additionalInfo;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 440,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColumnTitle(text: additionalInfo.columnName),
          const CommonSpacer(),
          Text(additionalInfo.columnData,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
