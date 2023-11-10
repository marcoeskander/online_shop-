class FavoritesModel {
  late bool status;
  late String message;

  FavoritesModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
