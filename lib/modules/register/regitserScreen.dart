import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/layout/shop_layout.dart';
import 'package:online_shop/modules/register/cubit/registerCubit.dart';
import 'package:online_shop/modules/register/cubit/registerState.dart';
import 'package:online_shop/shared/components/components.dart';
import 'package:online_shop/shared/components/constants.dart';
import 'package:online_shop/shared/network/local/sharedpr.dart';

class rigsterScreen extends StatelessWidget {
  var emailControler = TextEditingController();
  var phoneControler = TextEditingController();
  var nameControler = TextEditingController();
  var passwordControler = TextEditingController();
  var formKey = GlobalKey<FormState>();
  rigsterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.registerModel.status) {
              CacheHelper.saveData(
                key: 'token',
                value: state.registerModel.data!.token,
              ).then((value) {
                token = (state.registerModel.data!.token)!;
                navigatAndFinsh(context, const ShopLatyout());
              });
              showToast(
                message: state.registerModel.message,
                state: ToastStates.SUCCESS,
              );
            } else {
              print(state.registerModel.message);
              showToast(
                message: state.registerModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
          if (state is RegisterErrorState) {
            showToast(
                message: state.error.toString(), state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.0.w,
                vertical: 20.0.h,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultTextformfeild(
                      controller: nameControler,
                      textType: TextInputType.name,
                      valdiators: (String? value) {
                        if (value!.isEmpty) {
                          return 'UserName Must Not Be Null';
                        }
                        return null;
                      },
                      label: 'name',
                      prefex: Icons.person,
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    defaultTextformfeild(
                      controller: passwordControler,
                      textType: TextInputType.visiblePassword,
                      valdiators: (String? value) {
                        if (value!.isEmpty) {
                          return 'password Must Not Be Null';
                        }
                        return null;
                      },
                      label: 'password',
                      prefex: Icons.lock,
                      ischeck: RegisterCubit.get(context).ispassword,
                      sufex: RegisterCubit.get(context).sufixicon,
                      ispas: () {
                        RegisterCubit.get(context).changepass();
                      },
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    defaultTextformfeild(
                      controller: phoneControler,
                      textType: TextInputType.number,
                      valdiators: (String? value) {
                        if (value!.isEmpty) {
                          return 'phone Must Not Be Null';
                        }
                        return null;
                      },
                      label: 'phone',
                      prefex: Icons.phone,
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    defaultTextformfeild(
                      controller: emailControler,
                      textType: TextInputType.emailAddress,
                      valdiators: (String? value) {
                        if (value!.isEmpty) {
                          return 'email Must Not Be Null';
                        }
                        return null;
                      },
                      label: 'email',
                      prefex: Icons.email,
                    ),
                    SizedBox(
                      height: 20.0.h,
                    ),
                    ConditionalBuilder(
                      condition: state is! RegisterLoadingState,
                      builder: (context) => defaultbutton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            RegisterCubit.get(context).uaerregisr(
                              name: nameControler.text,
                              phone: phoneControler.text,
                              password: passwordControler.text,
                              email: emailControler.text,
                            );
                          }
                        },
                        text: 'signup',
                        iscase: true,
                      ),
                      fallback: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
