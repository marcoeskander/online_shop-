import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/models/shopRegister_model.dart';
import 'package:online_shop/modules/register/cubit/registerState.dart';
import 'package:online_shop/shared/network/endpoint.dart';
import 'package:online_shop/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  RegisterModel? registermodel;
  void uaerregisr({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(RegisterLoadingState());
    DioHelperShop.postData(url: Registere, data: {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
    }).then((value) {
      registermodel = RegisterModel.fromjson(value.data);
      emit(RegisterSuccessState(registermodel!));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterErrorState(error));
    });
  }

  IconData sufixicon = Icons.visibility;
  bool ispassword = true;
  void changepass() {
    ispassword = !ispassword;
    sufixicon = ispassword ? Icons.visibility : Icons.visibility_off_outlined;
    emit(ChangePasswordstate());
  }
}
