import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/screen/generation/components/common_spacer.dart';

class NameComponent extends StatelessWidget {
  const NameComponent(
      {Key? key, required this.koreanName, required this.englishName})
      : super(key: key);

  final String koreanName;
  final String englishName;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(koreanName,
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
      Text(englishName,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
      const CommonSpacer()
    ]);
  }
}
