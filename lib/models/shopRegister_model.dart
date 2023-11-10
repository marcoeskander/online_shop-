import 'package:online_shop/models/userData_model.dart';

class RegisterModel {
  late bool status;
  late String message;
  UserData? data;
  RegisterModel.fromjson(Map<dynamic, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromjson(json['data']) : null;
  }
}
