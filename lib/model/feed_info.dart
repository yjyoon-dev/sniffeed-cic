class FeedInfo {
  final String koreanName;
  final String englishName;
  final List<AdditionalInfo> additionalInfos;
  final IngredientTable ingredientTable;
  final SodiumInfo sodiumInfo;

  FeedInfo(
      {required this.koreanName,
      required this.englishName,
      required this.additionalInfos,
      required this.ingredientTable,
      required this.sodiumInfo});
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

class SodiumInfo {
  final String per100g;
  final String totalAvg;
  final String totalAvgSub;
  final String contentDegree;

  SodiumInfo(
      {required this.per100g,
      required this.totalAvg,
      required this.totalAvgSub,
      required this.contentDegree});
}
