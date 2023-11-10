import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/models/saerchmodel.dart';
import 'package:online_shop/modules/search/cubit/searchcubit.dart';
import 'package:online_shop/modules/search/cubit/searchstate.dart';
import 'package:online_shop/shared/components/components.dart';
import 'package:online_shop/shared/manager/color_manager.dart';

class search_screen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var searchcontrollar = TextEditingController();

  search_screen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sreachcubit(),
      child: BlocConsumer<sreachcubit, searchstate>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      defaultTextformfeild(
                        controller: searchcontrollar,
                        textType: TextInputType.text,
                        valdiators: (String? value) {
                          if (value!.isEmpty) {
                            return 'search must be not empty';
                          }
                          return null;
                        },
                        onsubmit: (String text) {
                          if (formKey.currentState!.validate()) {
                            sreachcubit.get(context).search(
                                  text: text,
                                );
                          }
                        },
                        label: 'search',
                        prefex: Icons.search,
                      ),
                      SizedBox(
                        height: 15.0.h,
                      ),
                      if (state is searchlodaingstate)
                        const LinearProgressIndicator(),
                      SizedBox(
                        height: 15.0.h,
                      ),
                      if (state is searchsucessstate)
                        Expanded(
                          child: ListView.separated(
                            itemBuilder: (context, index) => buildListProduct(
                              sreachcubit
                                  .get(context)
                                  .searchmodel!
                                  .data!
                                  .data![index],
                              context,
                            ),
                            separatorBuilder: (context, index) => SizedBox(
                              height: 12.h,
                            ),
                            itemCount: sreachcubit
                                .get(context)
                                .searchmodel!
                                .data!
                                .data!
                                .length,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}

Widget buildListProduct(
  DataDetails? model,
  context,
  //bool isOldPrice = true,
) =>
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 20.0.h),
      child: Container(
        height: 100.0.h,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model!.images![1]),
                  width: 100.0.w,
                  height: 100.0.h,
                ),
                // if (model.discount != 0 && isOldPrice)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0.w,
                  ),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0.sp,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20.0.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      height: 1.3.h,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: TextStyle(
                          fontSize: 12.0.sp,
                          color: ColorManager.defoultcolor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
