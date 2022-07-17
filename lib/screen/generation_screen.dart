import 'dart:convert' show utf8;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:sniffeed_content_image_creator/model/feed.dart';
import 'package:sniffeed_content_image_creator/model/hay.dart';
import 'package:sniffeed_content_image_creator/model/nutrient.dart';
import 'package:sniffeed_content_image_creator/model/sample/feed_info.dart';
import 'package:sniffeed_content_image_creator/screen/feed/feed_content.dart';
import 'package:sniffeed_content_image_creator/screen/hay/hay_content.dart';
import 'package:sniffeed_content_image_creator/screen/nutrient/nutrient_content.dart';
import 'package:sniffeed_content_image_creator/screen/sample/generation/feed_info_content.dart';
import 'dart:html' as html;
import 'dart:js' as js;

class GeneratingScreen extends StatefulWidget {
  const GeneratingScreen({Key? key}) : super(key: key);

  @override
  State<GeneratingScreen> createState() => _GeneratingScreenState();
}

class _GeneratingScreenState extends State<GeneratingScreen> {
  int _index = 0;
  String generationType = "사료";
  List<String> generationTypeList = ["사료", "영양제", "건초", "샘플"];
  var _items = null;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("스니피드 컨텐츠 이미지 생성기"),
        actions: [
          IconButton(
              onPressed: () {
                js.context.callMethod(
                    'open', ['https://github.com/yjyoon-dev/sniffeed-cic']);
              },
              icon: const Icon(Icons.info))
        ],
      ),
      backgroundColor: const Color(0xfff2ede9),
      floatingActionButton: _items != null
          ? FloatingActionButton(
              onPressed: (() {
                setState(() {
                  _items = null;
                });
              }),
              child: const Icon(Icons.refresh),
            )
          : null,
      body: Center(
          child: _items != null
              ? SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${_index + 1} / ${_items!.length}",
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
                                if (generationType == "사료") ...[
                                  Screenshot(
                                      child: FeedContent(feed: _items![_index]),
                                      controller: screenshotController),
                                ] else if (generationType == "건초") ...[
                                  Screenshot(
                                      child: HayContent(hay: _items![_index]),
                                      controller: screenshotController)
                                ] else if (generationType == "영양제") ...[
                                  Screenshot(
                                      child: NutrientContent(
                                          nutrient: _items![_index]),
                                      controller: screenshotController)
                                ] else if (generationType == "샘플") ...[
                                  Screenshot(
                                      child: SampleFeedInfoContent(
                                          feedInfo: _items![_index]),
                                      controller: screenshotController)
                                ],
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
                      style: TextStyle(color: Colors.grey)),
                  const SizedBox(width: 12),
                  DropdownButton<String>(
                    value: generationType,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    elevation: 16,
                    onChanged: (String? newValue) {
                      setState(() {
                        generationType = newValue!;
                      });
                    },
                    items: generationTypeList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ])),
    );
  }

  void setIndex(int index) {
    if (index < 0 || index == _items!.length) return;
    setState(() {
      _index = index;
    });
  }

  void downloadAllContentImages() async {
    for (int i = 0; i < _items!.length; i++) {
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
        ..download = '${_items![index].korean}.png';
      html.document.body!.children.add(anchor);
      anchor.click();
      html.Url.revokeObjectUrl(url);
    });
  }

  void importCsv() async {
    _index = 0;
    _items = null;

    FilePickerResult? csvFile = await FilePicker.platform.pickFiles(
        allowedExtensions: ['csv'],
        type: FileType.custom,
        allowMultiple: false);

    if (csvFile != null) {
      final bytes = utf8.decode(csvFile.files[0].bytes!);

      List<List<dynamic>> rowsAsListOfValues =
          const CsvToListConverter().convert(bytes);

      switch (generationType) {
        case "사료":
          readFeedCsv(rowsAsListOfValues);
          break;
        case "건초":
          readHayCsv(rowsAsListOfValues);
          break;
        case "영양제":
          readNutrientCsv(rowsAsListOfValues);
          break;
        case "샘플":
          readSampleCsv(rowsAsListOfValues);
          break;
      }
    }
  }

  void readFeedCsv(List<List<dynamic>> csvRows) {
    List<Feed> result = [];

    for (int i = 1; i < csvRows.length; i++) {
      Feed feed = Feed(
          korean: csvRows[i][0].toString(),
          english: csvRows[i][1].toString(),
          age: csvRows[i][2].toString(),
          weight: csvRows[i][3].toString() + "g",
          price: csvRows[i][4].toString() + "원",
          pricePer: csvRows[i][5].toString() + "원",
          amount: "-" + csvRows[i][6].toString().replaceAll('\n', '\n-'),
          material: csvRows[i][7].toString(),
          feature: "-" + csvRows[i][8].toString().replaceAll('\n', '\n-'),
          ingredient: csvRows[i][9].toString());
      result.add(feed);
    }

    setState(() {
      _items = result;
    });
  }

  void readHayCsv(List<List<dynamic>> csvRows) {
    List<Hay> result = [];

    for (int i = 1; i < csvRows.length; i++) {
      Hay hay = Hay(
          korean: csvRows[i][0].toString(),
          english: csvRows[i][1].toString(),
          weight: csvRows[i][2].toString() + "g",
          price: csvRows[i][3].toString() + "원",
          pricePer: csvRows[i][4].toString() + "원",
          material: csvRows[i][5].toString(),
          feature: "-" + csvRows[i][6].toString().replaceAll('\n', '\n-'));
      result.add(hay);
    }

    setState(() {
      _items = result;
    });
  }

  void readNutrientCsv(List<List<dynamic>> csvRows) {
    List<Nutrient> result = [];

    for (int i = 1; i < csvRows.length; i++) {
      Nutrient nutrient = Nutrient(
          korean: csvRows[i][0].toString(),
          english: csvRows[i][1].toString(),
          weight: csvRows[i][2].toString() + "g",
          count: csvRows[i][3].toString(),
          price: csvRows[i][4].toString() + "원",
          pricePer: csvRows[i][5].toString() + "원",
          amount: "-" + csvRows[i][6].toString().replaceAll('\n', '\n-'),
          material: csvRows[i][7].toString(),
          feature: "-" + csvRows[i][8].toString().replaceAll('\n', '\n-'),
          ingredient: csvRows[i][9].toString());
      result.add(nutrient);
    }

    setState(() {
      _items = result;
    });
  }

  void readSampleCsv(List<List<dynamic>> csvRows) {
    List<SampleFeedInfo> result = [];

    for (int i = 1; i < csvRows.length; i++) {
      var type =
          csvRows[i][2].toString() == "육식" ? FeedType.carn : FeedType.herb;
      var unit = (type == FeedType.carn ? "mg" : "g");

      SampleFeedInfo feedInfo = SampleFeedInfo(
          korean: csvRows[i][0].toString(),
          english: csvRows[i][1].toString(),
          type: type,
          additionalInfos: [
            AdditionalInfo(
                columnName: "추천 하루 급여량", columnData: csvRows[i][3].toString()),
            AdditionalInfo(
                columnName: "급여 시 참고 사항", columnData: csvRows[i][4].toString()),
            AdditionalInfo(
                columnName: "일반적 특성", columnData: csvRows[i][5].toString())
          ],
          ingredientTable: IngredientTable(per100g: [
            csvRows[i][6].toString() + "kcal",
            csvRows[i][7].toString() + "g",
            csvRows[i][8].toString() + "g",
            csvRows[i][9].toString() + "g",
            csvRows[i][10].toString() + "g",
            csvRows[i][11].toString() + "mg"
          ], totalAvg: [
            csvRows[i][12].toString() + "kcal",
            csvRows[i][13].toString() + "g",
            csvRows[i][14].toString() + "g",
            csvRows[i][15].toString() + "g",
            csvRows[i][16].toString() + "g",
            csvRows[i][17].toString() + "mg"
          ]),
          compareInfo: CompareInfo(
              type: type == FeedType.carn
                  ? CompareType.sodium
                  : CompareType.sugar,
              per100g: csvRows[i][18].toString() + unit,
              totalAvg: csvRows[i][19].toString() + unit,
              totalAvgSub: (csvRows[i][20].toString().startsWith('-')
                      ? csvRows[i][20].toString()
                      : '+' + csvRows[i][20].toString()) +
                  unit,
              contentDegree: csvRows[i][21].toString()));
      result.add(feedInfo);
    }

    setState(() {
      _items = result;
    });
  }
}
