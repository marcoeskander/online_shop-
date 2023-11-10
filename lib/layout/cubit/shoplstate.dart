import 'package:online_shop/models/changefavoretmodel.dart';
import 'package:online_shop/models/shopLogin_model.dart';
import 'package:online_shop/models/userData_model.dart';

abstract class ShopState {}

class InitailStateLayout extends ShopState {}

class ShopChangeBottomNavStateLayout extends ShopState {}

class ShopHomelodaingStateLayout extends ShopState {}

class ShopHomeScuccssStateLayout extends ShopState {}

class ShopHomeErrorStateLayout extends ShopState {}

class ShopcategoriesScuccssStateLayout extends ShopState {}

class ShopcategoriesErrorStateLayout extends ShopState {}

class ShopFavoritesScuccssStateLayout extends ShopState {
  final FavoritesModel model;
  ShopFavoritesScuccssStateLayout(this.model);
}

class ShopFavoritesStateLayout extends ShopState {}

class ShopFavoritesErrorStateLayout extends ShopState {
  final FavoritesModel model;
  ShopFavoritesErrorStateLayout(this.model);
}

class ShopgetFavoritesStatelodingLayout extends ShopState {}

class ShopgetFavoritesStateLayout extends ShopState {}

class ShopgetFavoritesErrorStateLayout extends ShopState {
  final FavoritesModel model;
  ShopgetFavoritesErrorStateLayout(this.model);
}

class ShopgetprofileStatelodingLayout extends ShopState {}

class ShopgetprofileStateLayout extends ShopState {}

class ShopgetprofileErrorStateLayout extends ShopState {
  final ShopLoginmodel model;
  ShopgetprofileErrorStateLayout(this.model);
}

class ShopchangepassStatelodingLayout extends ShopState {}

class ShopupdateaprofileStatelodingLayout extends ShopState {}

class ShopupdateprofileStateLayout extends ShopState {}

class ShopupdateprofileErrorStateLayout extends ShopState {
  final String model;
  ShopupdateprofileErrorStateLayout(this.model);
}
