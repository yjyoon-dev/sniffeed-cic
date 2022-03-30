import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/model/feed_info.dart';
import 'package:sniffeed_content_image_creator/screen/generation/components/column_title.dart';
import 'package:sniffeed_content_image_creator/screen/generation/components/common_spacer.dart';

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
          Text(additionalInfo.columnData, style: const TextStyle(fontSize: 22))
        ],
      ),
    );
  }
}
