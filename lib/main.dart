import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/screen/generation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sniffeed Image Content Creator',
      theme: ThemeData(primarySwatch: Colors.brown, fontFamily: 'Score_Dream'),
      home: const GeneratingScreen(),
    );
  }
}
