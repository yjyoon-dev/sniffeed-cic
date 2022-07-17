import 'package:flutter/material.dart';
import 'package:sniffeed_content_image_creator/model/sample/feed_info.dart';
import 'package:sniffeed_content_image_creator/screen/sample/generation/components/column_title.dart';
import 'package:sniffeed_content_image_creator/screen/sample/generation/components/common_spacer.dart';

class IngredientTableComponent extends StatelessWidget {
  const IngredientTableComponent({Key? key, required this.ingredientTable})
      : super(key: key);

  final IngredientTable ingredientTable;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ColumnTitle(text: "성분"),
        const CommonSpacer(),
        FittedBox(
          child: DataTable(
              columns: buildDataColumn(),
              rows: buildDataRow(),
              dataRowHeight: 32,
              dataRowColor: MaterialStateProperty.all(const Color(0xfff2ede9)),
              dataTextStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              headingRowColor:
                  MaterialStateProperty.all(const Color(0xffd6c4b6)),
              headingTextStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              headingRowHeight: 34,
              border: TableBorder.all(color: Colors.white, width: 2.0),
              dividerThickness: 0),
        )
      ],
    );
  }

  List<DataColumn> buildDataColumn() {
    List<String> columnNames = [
      "      ",
      "   열량  ",
      "탄수화물(g)",
      "단백질(g)",
      "지방(g)",
      "당분(g)",
      "나트륨(mg)"
    ];
    return List.generate(
        columnNames.length,
        (index) => DataColumn(
            label: Center(
                child: Text(columnNames[index], textAlign: TextAlign.center))));
  }

  List<DataRow> buildDataRow() {
    return [
      DataRow(
          cells: List.generate(
              ingredientTable.per100g.length + 1,
              (index) => DataCell(Center(
                    child: Text(
                        index == 0
                            ? "(100g 당)"
                            : ingredientTable.per100g[index - 1],
                        textAlign: TextAlign.center,
                        maxLines: 1),
                  )))),
      DataRow(
          cells: List.generate(
              ingredientTable.totalAvg.length + 1,
              (index) => DataCell(Center(
                    child: Text(
                        index == 0
                            ? "전체 평균"
                            : ingredientTable.totalAvg[index - 1],
                        textAlign: TextAlign.center,
                        maxLines: 1),
                  ))))
    ];
  }
}
