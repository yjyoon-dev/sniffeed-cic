import 'dart:convert' show utf8;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:sniffeed_content_image_creator/model/feed_info.dart';
import 'package:sniffeed_content_image_creator/screen/generation/feed_info_content.dart';
import 'dart:html' as html;
import 'package:universal_io/io.dart';

class GeneratingScreen extends StatefulWidget {
  const GeneratingScreen({Key? key}) : super(key: key);

  @override
  State<GeneratingScreen> createState() => _GeneratingScreenState();
}

class _GeneratingScreenState extends State<GeneratingScreen> {
  int _index = 0;
  List<FeedInfo>? _feedInfos;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("스니피드 콘텐츠 이미지 생성기"),
      ),
      backgroundColor: const Color(0xfff2ede9),
      floatingActionButton: _feedInfos != null
          ? FloatingActionButton(
              onPressed: importCsv,
              child: const Icon(Icons.add),
            )
          : null,
      body: Center(
          child: _feedInfos != null
              ? SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${_index + 1} / ${_feedInfos!.length}",
                            style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 32),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                    onPressed: () {
                                      setIndex(_index - 1);
                                    },
                                    child:
                                        const Icon(Icons.arrow_back_ios_new)),
                                const SizedBox(width: 32),
                                Screenshot(
                                    child: FeedInfoContent(
                                        feedInfo: _feedInfos![_index]),
                                    controller: screenshotController),
                                const SizedBox(width: 32),
                                FloatingActionButton(
                                    onPressed: () {
                                      setIndex(_index + 1);
                                    },
                                    child: const Icon(Icons.arrow_forward_ios)),
                              ]),
                        ),
                        const SizedBox(height: 32),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton(
                                  onPressed: () {
                                    downloadContentImage(_index);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              vertical: 24, horizontal: 32))),
                                  child: const Text("현재 이미지 다운로드",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                  onPressed: downloadAllContentImages,
                                  style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              vertical: 24, horizontal: 24))),
                                  child: const Text("전체 이미지 다운로드",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)))
                            ])
                      ]),
                )
              : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FloatingActionButton(
                    onPressed: importCsv,
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 16),
                  const Text("CSV 파일 불러오기",
                      style: TextStyle(color: Colors.grey))
                ])),
    );
  }

  void setIndex(int index) {
    if (index < 0 || index == _feedInfos!.length) return;
    setState(() {
      _index = index;
    });
  }

  void downloadAllContentImages() async {
    for (int i = 0; i < _feedInfos!.length; i++) {
      await downloadContentImage(i);
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<void> downloadContentImage(int index) async {
    setIndex(index);
    await Future.delayed(const Duration(seconds: 1));
    screenshotController.capture().then((value) {
      final blob = html.Blob([value]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = '${_feedInfos![index].koreanName}.png';
      html.document.body!.children.add(anchor);
      anchor.click();
      html.Url.revokeObjectUrl(url);
    });
  }

  void importCsv() async {
    _index = 0;
    _feedInfos = null;

    FilePickerResult? csvFile = await FilePicker.platform.pickFiles(
        allowedExtensions: ['csv'],
        type: FileType.custom,
        allowMultiple: false);

    if (csvFile != null) {
      final bytes = utf8.decode(csvFile.files[0].bytes!);

      List<List<dynamic>> rowsAsListOfValues =
          const CsvToListConverter().convert(bytes);

      readCsv(rowsAsListOfValues);
    }
  }

  void readCsv(List<List<dynamic>> csvRows) {
    List<FeedInfo> result = [];

    for (int i = 1; i < csvRows.length; i++) {
      FeedInfo feedInfo = FeedInfo(
          koreanName: csvRows[i][0].toString(),
          englishName: csvRows[i][1].toString(),
          additionalInfos: [
            AdditionalInfo(
                columnName: "추천 하루 급여량", columnData: csvRows[i][2].toString()),
            AdditionalInfo(
                columnName: "급여 시 참고 사항", columnData: csvRows[i][3].toString()),
            AdditionalInfo(
                columnName: "일반적 특성", columnData: csvRows[i][4].toString())
          ],
          ingredientTable: IngredientTable(per100g: [
            csvRows[i][5].toString() + "kcal",
            csvRows[i][6].toString() + "g",
            csvRows[i][7].toString() + "g",
            csvRows[i][8].toString() + "g",
            csvRows[i][9].toString() + "g",
            csvRows[i][10].toString() + "mg"
          ], totalAvg: [
            csvRows[i][11].toString() + "kcal",
            csvRows[i][12].toString() + "g",
            csvRows[i][13].toString() + "g",
            csvRows[i][14].toString() + "g",
            csvRows[i][15].toString() + "g",
            csvRows[i][16].toString() + "mg"
          ]),
          sodiumInfo: SodiumInfo(
              per100g: csvRows[i][17].toString() + "mg",
              totalAvg: csvRows[i][18].toString() + "mg",
              totalAvgSub: csvRows[i][19].toString() + "mg",
              contentDegree: csvRows[i][20].toString()));
      result.add(feedInfo);
    }

    setState(() {
      _feedInfos = result;
    });
  }
}
