import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_shop/modules/login/shopLoginScreen.dart';
import 'package:online_shop/shared/components/components.dart';
import 'package:online_shop/shared/manager/color_manager.dart';
import 'package:online_shop/shared/manager/font_manager.dart';
import 'package:online_shop/shared/manager/styles_manager.dart';
import 'package:online_shop/shared/network/local/sharedpr.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class onbordingScreen extends StatefulWidget {
  @override
  @override
  State<onbordingScreen> createState() => _onbordingScreen();
}

class onbording_model {
  String? image;
  String? title;
  String? body;

  onbording_model({this.image, this.title, this.body});
}

class _onbordingScreen extends State<onbordingScreen> {
  var bordController = PageController();
  bool isLast = false;
  void submit() {
    CacheHelper.saveData(key: 'onbording', value: true).then((value) {
      navigatAndFinsh(context, loginScreen());
    });
  }

  List<onbording_model> bordItems = [
    onbording_model(
      image: 'assets/images/firstonbording.png',
      title: '  PURCHASE ONLINE ',
      body: 'FAINF YOUR PRODACT WITH BEST PRICE',
    ),
    onbording_model(
      image: 'assets/images/secondonbording.png',
      title: '  TRACK YOUR ORDER ',
      body: 'MKAE IT EASLY ',
    ),
    onbording_model(
      image: 'assets/images/thirdonbording.png',
      title: '  GET YOUR IRDER',
      body: 'DELIVARY FASTER ',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: Text(
              'Skip',
              style: getBoldStyle(
                  color: ColorManager.white, fontSize: FontSize.s20),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: bordController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (value) {
                  if (value == bordItems.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    borditem(model: bordItems[index]),
                itemCount: bordItems.length,
              ),
            ),
            SizedBox(
              height: 20.0.h,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: bordController,
                  count: bordItems.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 10.0.w,
                    dotHeight: 10.0.h,
                    dotColor: ColorManager.grey,
                    activeDotColor: ColorManager.primary,
                    expansionFactor: 4,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      bordController.nextPage(
                          duration: const Duration(
                            microseconds: 370,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(
                    Icons.arrow_right,
                    size: 50.0.r,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget borditem({
  required onbording_model model,
}) {
  return Column(
    children: [
      Expanded(
          child: Image(
        image: AssetImage(
          model.image!,
        ),
      )),
      SizedBox(
        height: 15.0.h,
      ),
      Text(
        model.title!,
        style: getBoldStyle(
          color: ColorManager.black,
          fontSize: FontSize.s20,
        ),
      ),
      SizedBox(
        height: 15.0.h,
      ),
      Text(
        model.body!,
        style: getBoldStyle(
          color: ColorManager.black,
          fontSize: FontSize.s20,
        ),
      ),
    ],
  );
}
