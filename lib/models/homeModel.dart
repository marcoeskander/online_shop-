class HomeModel {
  late bool status;
  late HomeDataModel data;
  HomeModel.fromjason(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromjason(json['data']);
  }
}

class HomeDataModel {
  List<BannarModel> banners = [];
  List<ProdactModel> products = [];
  HomeDataModel.fromjason(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannarModel.fromjason(element));
    });
    json['products'].forEach((element) {
      products.add(ProdactModel.fromjason(element));
    });
  }
}

class BannarModel {
  dynamic id;
  late String image;
  BannarModel.fromjason(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProdactModel {
  late int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  late String image;
  late String name;
  late bool in_favorites;
  late bool in_cart;
  ProdactModel.fromjason(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}
