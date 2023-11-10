import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/layout/cubit/cubitshop.dart';
import 'package:online_shop/layout/cubit/shoplstate.dart';
import 'package:online_shop/models/categoriesModel.dart';
import 'package:online_shop/models/homeModel.dart';
import 'package:online_shop/shared/components/components.dart';
import 'package:online_shop/shared/manager/color_manager.dart';
import 'package:online_shop/shared/manager/font_manager.dart';
import 'package:online_shop/shared/manager/styles_manager.dart';

class prodact_sc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitShop, ShopState>(
      listener: (context, state) {
        if (state is ShopFavoritesScuccssStateLayout) {
          if (!state.model.status) {
            showToast(message: state.model.message, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: CubitShop.get(context).homemodel != null &&
              CubitShop.get(context).Categoriesmodel != null,
          builder: (context) => prodactBulder(CubitShop.get(context).homemodel!,
              CubitShop.get(context).Categoriesmodel, context),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget prodactBulder(
          HomeModel model, CategoriesModel Categoriesmodel, context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 250.0.h,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                viewportFraction: 1.0,
                autoPlayInterval: const Duration(
                  seconds: 3,
                ),
                autoPlayAnimationDuration: const Duration(
                  seconds: 1,
                ),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10.0.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    textAlign: TextAlign.center,
                    style: getBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s24),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),
                  Container(
                    height: 100.0.h,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            buildcategoryitem(Categoriesmodel.data.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 15.0.w,
                            ),
                        itemCount: Categoriesmodel.data.data.length),
                  ),
                  SizedBox(
                    height: 10.0.h,
                  ),
                  Text(
                    ' products',
                    textAlign: TextAlign.center,
                    style: getBoldStyle(
                        color: ColorManager.black, fontSize: FontSize.s24),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.0.h,
            ),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 0.5.h,
              crossAxisSpacing: 0.5.w,
              childAspectRatio: 1 / 1.61,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                model.data.products.length,
                (index) => buildprodact(model.data.products[index], context),
              ),
            ),
          ],
        ),
      );
}

Widget buildcategoryitem(CurrentPageData model) => Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 100.0.h,
          height: 100.0.w,
          fit: BoxFit.cover,
        ),
        Container(
          color: Colors.black.withOpacity(0.6),
          width: 100.0.w,
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getRegularStyle(
                color: ColorManager.white, fontSize: FontSize.s16),
          ),
        ),
      ],
    );

Widget buildprodact(ProdactModel model, context) => Container(
      color: ColorManager.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 150.0.h,
              ),
              if (model.discount != 0)
                Container(
                  color: ColorManager.error,
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: Text(
                    'discound',
                    style: getMediumStyle(
                        color: ColorManager.white, fontSize: FontSize.s12),
                  ),
                ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.0.w,
              vertical: 5.0.h,
            ),
            child: Column(
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: getMediumStyle(
                      color: ColorManager.black, fontSize: FontSize.s12),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      style: getMediumStyle(
                          color: ColorManager.primary, fontSize: FontSize.s12),
                    ),
                    SizedBox(
                      width: 5.0.w,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.old_price.round()}',
                        style: getMediumStyle(
                            color: ColorManager.grey, fontSize: FontSize.s12),
                      ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          CubitShop.get(context)
                              .changeFavoritesData(prodactId: model.id);
                        },
                        icon: CircleAvatar(
                          radius: 10.0.r,
                          backgroundColor:
                              CubitShop.get(context).favoret[model.id]!
                                  ? ColorManager.primary
                                  : ColorManager.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 12.0,
                            color: ColorManager.white,
                          ),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
