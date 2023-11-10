import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/layout/cubit/cubitshop.dart';
import 'package:online_shop/layout/cubit/shoplstate.dart';
import 'package:online_shop/models/categoriesModel.dart';
import 'package:online_shop/shared/components/components.dart';
import 'package:online_shop/shared/manager/color_manager.dart';
import 'package:online_shop/shared/manager/font_manager.dart';
import 'package:online_shop/shared/manager/styles_manager.dart';

class category_sc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShop, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: CubitShop.get(context).Categoriesmodel != null,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => itemcatbuild(
                CubitShop.get(context).Categoriesmodel.data.data[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: CubitShop.get(context).Categoriesmodel.data.data.length,
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget itemcatbuild(CurrentPageData model) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0..h),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120.0.w,
              height: 120.0.h,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0.h,
            ),
            Text(
              model.name,
              style: getRegularStyle(
                  color: ColorManager.grey, fontSize: FontSize.s18),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
