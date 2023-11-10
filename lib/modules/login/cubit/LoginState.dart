import 'package:online_shop/models/shopLogin_model.dart';

abstract class shopLoginState {}

class shopInitialState extends shopLoginState {}

class shopLoadingState extends shopLoginState {}

class shopSuccessState extends shopLoginState {
  late final ShopLoginmodel loginModel;
  shopSuccessState(this.loginModel);
}

class shopErrorState extends shopLoginState {
  late final String error;
  shopErrorState(this.error);
}

class shopChangePasswordState extends shopLoginState {}
