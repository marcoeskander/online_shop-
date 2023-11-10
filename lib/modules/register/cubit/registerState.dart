import 'package:online_shop/models/shopRegister_model.dart';

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  late final RegisterModel registerModel;
  RegisterSuccessState(this.registerModel);
}

class RegisterErrorState extends RegisterState {
  late final RegisterModel error;
  RegisterErrorState(this.error);
}

class ChangePasswordstate extends RegisterState {}
