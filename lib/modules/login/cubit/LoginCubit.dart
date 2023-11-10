import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/models/shopLogin_model.dart';
import 'package:online_shop/modules/login/cubit/LoginState.dart';
import 'package:online_shop/shared/network/endpoint.dart';
import 'package:online_shop/shared/network/remote/dio_helper.dart';

class shopLoginCubit extends Cubit<shopLoginState> {
  shopLoginCubit() : super(shopInitialState());
  static shopLoginCubit get(context) => BlocProvider.of(context);

  late ShopLoginmodel loginModel;
  void uaerlogin({
    required String email,
    required String password,
  }) {
    emit(shopLoadingState());
    DioHelperShop.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(ShopLoginmodel.fromjson(value.data));
      loginModel = ShopLoginmodel.fromjson(value.data);
      emit(shopSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(shopErrorState(error.toString()));
    });
  }

  IconData sufixicon = Icons.visibility;
  bool ispassword = true;
  void changePassword_obscure() {
    ispassword = !ispassword;
    sufixicon = ispassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(shopChangePasswordState());
  }
}
