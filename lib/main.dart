import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/layout/shop_layout.dart';
import 'package:online_shop/modules/login/shopLoginScreen.dart';
import 'package:online_shop/modules/on_bording/onbordingScreen.dart';
import 'package:online_shop/shared/blocobserver.dart';
import 'package:online_shop/shared/components/constants.dart';
import 'package:online_shop/shared/network/local/sharedpr.dart';
import 'package:online_shop/shared/network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelperShop.init();
  await CacheHelper.init();
  bool? onbording = CacheHelper.getdata(key: 'onbording');
  Widget? startWidged;
  token = CacheHelper.getdata(key: 'token');
  if (onbording != null) {
    if (token != null) {
      startWidged = ShopLatyout();
    } else {
      startWidged = loginScreen();
    }
  } else {
    startWidged = onbordingScreen();
  }
  runApp(MyApp(
    startwidget: startWidged,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startwidget;
  const MyApp({super.key, required this.startwidget});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: startwidget,
      ),
    );
  }
}
