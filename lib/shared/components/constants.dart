import 'package:online_shop/modules/login/shopLoginScreen.dart';
import 'package:online_shop/shared/components/components.dart';
import 'package:online_shop/shared/network/local/sharedpr.dart';

void SignOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    navigatAndFinsh(
      context,
      loginScreen(),
    );
  });
}

String? token;
