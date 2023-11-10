class UserData {
  dynamic id;
  String? email;
  String? name;
  String? phone;
  String? image;
  dynamic point;
  dynamic credit;
  String? token;

  //namedconsractor
  UserData.fromjson(Map<String, dynamic> jason) {
    id = jason['id'];
    name = jason['name'];
    email = jason['email'];
    phone = jason['phone'];
    image = jason['image'];
    point = jason['point'];
    credit = jason['credit'];
    token = jason['token'];
  }
}
