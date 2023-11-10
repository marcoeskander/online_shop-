import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_shop/layout/cubit/cubitshop.dart';
import 'package:online_shop/shared/manager/color_manager.dart';
import 'package:online_shop/shared/manager/font_manager.dart';
import 'package:online_shop/shared/manager/styles_manager.dart';

Widget defaultbutton({
  double width = double.infinity,
  double height = 40.0,
  Color background = Colors.blue,
  required Function function,
  required String text,
  bool iscase = true,
  double radius = 0.0,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          iscase ? text.toUpperCase() : text,
          style: getSemiBoldStyle(
              color: ColorManager.white, fontSize: FontSize.s20),
        ),
      ),
    );
Widget defaultTextformfeild({
  required TextEditingController controller,
  required TextInputType textType,
  bool obscure_text = false,
  Function? onsubmit,
  Function? ontap,
  Function? onchanng,
  required String? Function(String?)? valdiators,
  required String label,
  IconData? prefex,
  IconData? sufex,
  Function? ispas,
  bool ischeck = true,
}) =>
    TextFormField(
      enabled: ischeck,
      controller: controller,
      keyboardType: textType,
      obscureText: obscure_text,
      onChanged: (s) {
        if (onchanng != null) {
          onchanng(s);
        }
      },
      onTap: () {
        if (ontap != null) {
          ontap();
        }
      },
      onFieldSubmitted: (value) {
        if (onsubmit != null) {
          onsubmit(value);
        }
      },
      validator: valdiators,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefex),
        suffixIcon: sufex != null
            ? GestureDetector(
                onTap: () {
                  ispas!();
                },
                child: Icon(
                  sufex,
                ),
              )
            : null,
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 10.0,
      ),
      child: Container(
        color: ColorManager.grey,
        height: 1.0.h,
        width: double.infinity,
      ),
    );
void navigatTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
void navigatAndFinsh(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void showToast({
  required String message,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: choiseColor(state: state),
      timeInSecForIosWeb: 4,
      textColor: ColorManager.white,
      fontSize: FontSize.s16,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color choiseColor({required ToastStates state}) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = ColorManager.success;
      break;
    case ToastStates.ERROR:
      color = ColorManager.error;
      break;
    case ToastStates.WARNING:
      color = ColorManager.warning;
      break;
  }
  return color;
}

Widget buildlistproduct(facdata, context, {bool isoldprise = true}) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(facdata.image!),
                  width: 100.0.w,
                  height: 100.0.h,
                  fit: BoxFit.cover,
                ),
                if (facdata.discount != 0 && isoldprise)
                  Container(
                    color: ColorManager.error,
                    padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                    child: Text(
                      ' discount',
                      style: getMediumStyle(
                        color: ColorManager.white,
                        fontSize: FontSize.s12,
                      ),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    facdata.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      height: 1.2.h,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        ' ${facdata.price}',
                        style: getSemiBoldStyle(
                          color: ColorManager.primary,
                          fontSize: FontSize.s12,
                        ),
                      ),
                      SizedBox(
                        width: 15.0.w,
                      ),
                      if (facdata.discount != 0 && isoldprise)
                        Text(
                          ' ${facdata.oldPrice}',
                          style: TextStyle(
                            fontSize: FontSize.s12,
                            color: ColorManager.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            CubitShop.get(context)
                                .changeFavoritesData(prodactId: facdata.id!);
                          },
                          icon: CircleAvatar(
                            radius: 15.0.r,
                            backgroundColor:
                                CubitShop.get(context).favoret[facdata.id]!
                                    ? ColorManager.defoultcolor
                                    : ColorManager.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 12.0.sp,
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
      ),
    );
