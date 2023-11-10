import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/layout/shop_layout.dart';
import 'package:online_shop/modules/login/cubit/LoginCubit.dart';
import 'package:online_shop/modules/login/cubit/LoginState.dart';
import 'package:online_shop/modules/register/regitserScreen.dart';
import 'package:online_shop/shared/components/components.dart';
import 'package:online_shop/shared/components/constants.dart';
import 'package:online_shop/shared/manager/color_manager.dart';
import 'package:online_shop/shared/manager/font_manager.dart';
import 'package:online_shop/shared/manager/styles_manager.dart';
import 'package:online_shop/shared/network/local/sharedpr.dart';

class loginScreen extends StatelessWidget {
  var emailcontrolar = TextEditingController();
  var passwordcontrolar = TextEditingController();
  var formKey = GlobalKey<FormState>();

  loginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => shopLoginCubit(),
      child: BlocConsumer<shopLoginCubit, shopLoginState>(
        listener: (context, state) {
          if (state is shopSuccessState) {
            if (state.loginModel.status!) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = (state.loginModel.data!.token)!;
                navigatAndFinsh(context, ShopLatyout());
                emailcontrolar.clear();
                passwordcontrolar.clear();
              });
              showToast(
                message: state.loginModel.message!,
                state: ToastStates.SUCCESS,
              );
            } else {
              print(state.loginModel.message);
              showToast(
                message: state.loginModel.message!,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s20),
                      ),
                      Text(
                        'login now to browse our host offer',
                        style: getBoldStyle(
                            color: ColorManager.grey, fontSize: FontSize.s16),
                      ),
                      SizedBox(
                        height: 20.0.h,
                      ),
                      defaultTextformfeild(
                        controller: emailcontrolar,
                        textType: TextInputType.emailAddress,
                        valdiators: (String? value) {
                          if (value!.isEmpty) {
                            return 'email must not be empty';
                          }
                          return null;
                        },
                        onchanng: (value) {
                          print(value);
                        },
                        ontap: () {},
                        label: 'EMAIL ADDRESS',
                        prefex: Icons.email_outlined,
                      ),
                      SizedBox(
                        height: 20.0.h,
                      ),
                      defaultTextformfeild(
                        controller: passwordcontrolar,
                        textType: TextInputType.visiblePassword,
                        valdiators: (String? value) {
                          if (value!.isEmpty) {
                            return 'password must not be empty';
                          }
                          return null;
                        },
                        onsubmit: (s) {
                          if (formKey.currentState!.validate()) {
                            shopLoginCubit.get(context).uaerlogin(
                                  email: emailcontrolar.text,
                                  password: passwordcontrolar.text,
                                );
                          }
                        },
                        onchanng: (value) {
                          print(value);
                        },
                        ontap: () {},
                        label: 'password',
                        obscure_text: shopLoginCubit.get(context).ispassword,
                        prefex: Icons.lock_clock_outlined,
                        sufex: shopLoginCubit.get(context).sufixicon,
                        ispas: () {
                          shopLoginCubit.get(context).changePassword_obscure();
                        },
                      ),
                      SizedBox(
                        height: 20.0.h,
                      ),
                      ConditionalBuilder(
                        condition: state is! shopLoadingState,
                        builder: (context) => defaultbutton(
                          function: () {
                            if (formKey.currentState!.validate()) {
                              shopLoginCubit.get(context).uaerlogin(
                                  email: emailcontrolar.text,
                                  password: passwordcontrolar.text);
                            }
                          },
                          text: 'login',
                          iscase: true,
                        ),
                        fallback: (context) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: 20.0.h,
                      ),
                      Row(
                        children: [
                          Text(
                            'don\'t have an account? ',
                            style: getSemiBoldStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s16),
                          ),
                          TextButton(
                            onPressed: () {
                              navigatTo(context, rigsterScreen());
                            },
                            child: Text(
                              'register now',
                              style: getSemiBoldStyle(
                                  color: ColorManager.primary,
                                  fontSize: FontSize.s16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
