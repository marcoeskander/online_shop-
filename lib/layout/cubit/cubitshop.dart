import 'package:flutter/material.dart';
import 'package:online_shop/layout/cubit/shoplstate.dart';
import 'package:online_shop/models/categoriesModel.dart';
import 'package:online_shop/models/changefavoretmodel.dart';
import 'package:online_shop/models/favoretsmodel.dart';
import 'package:online_shop/models/shopLogin_model.dart';
import 'package:online_shop/models/homeModel.dart';
import 'package:online_shop/models/userData_model.dart';
import 'package:online_shop/modules/categores/categorys.dart';
import 'package:online_shop/modules/favoret/favorets.dart';
import 'package:online_shop/modules/prodact/product_Screen.dart';
import 'package:online_shop/modules/seteings/settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/shared/components/constants.dart';
import 'package:online_shop/shared/network/endpoint.dart';
import 'package:online_shop/shared/network/remote/dio_helper.dart';

class CubitShop extends Cubit<ShopState> {
  CubitShop() : super(InitailStateLayout());
  static CubitShop get(context) => BlocProvider.of(context);
  int currentindex = 0;
  List<String> title = ['Home', 'Categoty', 'Favoret', 'Profile'];
  List<Widget> bottomscreen = [
    prodact_sc(),
    category_sc(),
    favoret_sc(),
    settingScreen(),
  ];

  void changebottom(int index) {
    currentindex = index;
    emit(ShopChangeBottomNavStateLayout());
  }

  HomeModel? homemodel;
  Map<int, bool> favoret = {};
  void getHomeData() {
    emit(ShopHomelodaingStateLayout());
    DioHelperShop.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homemodel = HomeModel.fromjason(value.data);
      homemodel!.data.products.forEach((element) {
        favoret.addAll({
          element.id: element.in_favorites,
        });
      });

      emit(ShopHomeScuccssStateLayout());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeErrorStateLayout());
    });
  }

  late CategoriesModel Categoriesmodel;
  void getCategorieData() {
    DioHelperShop.getData(
      url: Categories,
    ).then((value) {
      Categoriesmodel = CategoriesModel.fromjson(value!.data);

      emit(ShopcategoriesScuccssStateLayout());
    }).catchError((error) {
      print(error.toString());
      emit(ShopcategoriesErrorStateLayout());
    });
  }

  FavoritesModel? Favoritesmodel;
  void changeFavoritesData({required int prodactId}) {
    favoret[prodactId] = !(favoret[prodactId])!;
    emit(ShopFavoritesStateLayout());
    DioHelperShop.postData(
      url: Favorites,
      token: token,
      data: {
        'product_id': prodactId,
      },
    ).then((value) {
      Favoritesmodel = FavoritesModel.fromjson(value.data);
      if (!Favoritesmodel!.status) {
        favoret[prodactId] = !favoret[prodactId]!;
      } else {
        getfavoretsData();
      }

      emit(ShopFavoritesScuccssStateLayout(Favoritesmodel!));
    }).catchError((error) {
      favoret[prodactId] = !favoret[prodactId]!;
      emit(ShopFavoritesErrorStateLayout(Favoritesmodel!));
    });
  }

  favoretsmodel? favoretsModel;
  void getfavoretsData() {
    emit(ShopgetFavoritesStatelodingLayout());
    DioHelperShop.getData(
      url: Favorites,
      token: token,
    ).then((value) {
      favoretsModel = favoretsmodel.fromJson(value.data);

      emit(ShopgetFavoritesStateLayout());
    }).catchError((error) {
      print(error.toString());
      emit(ShopgetFavoritesErrorStateLayout(error));
    });
  }

  ShopLoginmodel? usermodel;
  void getprofileData() {
    emit(ShopgetprofileStatelodingLayout());
    DioHelperShop.getData(
      url: 'profile',
      token: token,
    ).then((value) {
      usermodel = ShopLoginmodel.fromjson(value.data);

      emit(ShopgetprofileStateLayout());
    }).catchError((error) {
      emit(ShopgetprofileErrorStateLayout(error));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopupdateaprofileStatelodingLayout());
    DioHelperShop.putData(data: {
      'name': name,
      'email': email,
      'phone': phone,
    }, url: updateprofile, token: token)
        .then((value) {
      usermodel = ShopLoginmodel.fromjson(value.data);
      emit(ShopupdateprofileStateLayout());
    }).catchError((error) {
      print(error.toString());
      emit(ShopupdateprofileErrorStateLayout(error.toString()));
    });
  }
}
