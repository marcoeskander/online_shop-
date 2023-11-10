import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/layout/cubit/cubitshop.dart';
import 'package:online_shop/layout/cubit/shoplstate.dart';
import 'package:online_shop/shared/components/components.dart';
import 'package:online_shop/shared/components/constants.dart';

class settingScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailControler = TextEditingController();
  var phonecontroler = TextEditingController();
  var namecontroler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShop, ShopState>(listener: (context, state) {
      if (state is ShopHomeScuccssStateLayout) {
        emailControler.text = CubitShop.get(context).usermodel!.data!.email!;
        namecontroler.text = CubitShop.get(context).usermodel!.data!.name!;
        phonecontroler.text = CubitShop.get(context).usermodel!.data!.phone!;
      }
    }, builder: (context, state) {
      emailControler.text = CubitShop.get(context).usermodel!.data!.email!;
      namecontroler.text = CubitShop.get(context).usermodel!.data!.name!;
      phonecontroler.text = CubitShop.get(context).usermodel!.data!.phone!;
      return ConditionalBuilder(
        condition: CubitShop.get(context).usermodel != null,
        builder: (context) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0.w,
            vertical: 20.0.h,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                if (state is ShopupdateaprofileStatelodingLayout)
                  const LinearProgressIndicator(),
                SizedBox(
                  height: 20.0.h,
                ),
                defaultTextformfeild(
                  controller: namecontroler,
                  textType: TextInputType.name,
                  valdiators: (String? value) {
                    if (value!.isEmpty) {
                      return 'name mut be not be embty';
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
                  controller: emailControler,
                  textType: TextInputType.emailAddress,
                  valdiators: (String? value) {
                    if (value!.isEmpty) {
                      return 'email mut be not be embty';
                    }
                    return null;
                  },
                  label: 'email',
                  prefex: Icons.email,
                ),
                SizedBox(
                  height: 20.0.h,
                ),
                defaultTextformfeild(
                  controller: phonecontroler,
                  textType: TextInputType.number,
                  valdiators: (String? value) {
                    if (value!.isEmpty) {
                      return 'phone mut be not be embty';
                    }
                    return null;
                  },
                  label: 'phone',
                  prefex: Icons.phone,
                ),
                SizedBox(
                  height: 20.0.h,
                ),
                defaultbutton(
                  function: () {
                    if (formKey.currentState!.validate()) {
                      CubitShop.get(context).updateUserData(
                        email: emailControler.text,
                        phone: phonecontroler.text,
                        name: namecontroler.text,
                      );
                    }
                  },
                  text: 'update',
                ),
                SizedBox(
                  height: 20.0.h,
                ),
                defaultbutton(
                  function: () {
                    SignOut(context);
                  },
                  text: 'logout',
                ),
              ],
            ),
          ),
        ),
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      );
    });
  }
}
