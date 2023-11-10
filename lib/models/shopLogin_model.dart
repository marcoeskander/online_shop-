import 'package:online_shop/models/userData_model.dart';

class ShopLoginmodel {
  late bool? status;
  String? message;
  UserData? data;
  ShopLoginmodel.fromjson(Map<String, dynamic> jason) {
    status = jason['status'];
    message = jason['message'];
    data = jason['data'] != null ? UserData.fromjson(jason['data']) : null;
  }
}
