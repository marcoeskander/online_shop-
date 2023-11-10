import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/layout/cubit/cubitshop.dart';
import 'package:online_shop/layout/cubit/shoplstate.dart';
import 'package:online_shop/shared/components/components.dart';
import 'package:online_shop/shared/manager/color_manager.dart';
import 'package:online_shop/shared/manager/font_manager.dart';
import 'package:online_shop/shared/manager/styles_manager.dart';

class favoret_sc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShop, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: true,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildlistproduct(
                CubitShop.get(context)
                    .favoretsModel!
                    .data!
                    .data![index]
                    .product!,
                context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: CubitShop.get(context).favoretsModel!.data!.data!.length,
          ),
          fallback: (context) => Center(
              child: Text(
            'Empty',
            style:
                getBoldStyle(color: ColorManager.grey, fontSize: FontSize.s30),
          )),
        );
      },
    );
  }
}
