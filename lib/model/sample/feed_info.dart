enum FeedType { carn, herb }

enum CompareType { sodium, sugar }

class SampleFeedInfo {
  final String korean;
  final String english;
  final FeedType type;
  final List<AdditionalInfo> additionalInfos;
  final IngredientTable ingredientTable;
  final CompareInfo compareInfo;

  SampleFeedInfo(
      {required this.korean,
      required this.english,
      required this.type,
      required this.additionalInfos,
      required this.ingredientTable,
      required this.compareInfo});
}

class AdditionalInfo {
  final String columnName;
  final String columnData;

  AdditionalInfo({required this.columnName, required this.columnData});
}

class IngredientTable {
  // 열량, 탄수화물, 단백질, 지방, 당분 나트륨 (size = 6)
  final List<String> per100g;
  final List<String> totalAvg;

  IngredientTable({required this.per100g, required this.totalAvg});
}

class CompareInfo {
  final CompareType type;
  final String per100g;
  final String totalAvg;
  final String totalAvgSub;
  final String contentDegree;

  CompareInfo(
      {required this.type,
      required this.per100g,
      required this.totalAvg,
      required this.totalAvgSub,
      required this.contentDegree});
}
