class CategoriesModel {
  late bool status;
  late CategoriesDataModel data;
  CategoriesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromjson(json['data']);
  }
}

class CategoriesDataModel {
  late int current_page;
  late List<CurrentPageData> data = [];
  CategoriesDataModel.fromjson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(CurrentPageData.fromjson(element));
    });
  }
}

class CurrentPageData {
  late int id;
  late String name;
  late String image;
  CurrentPageData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
