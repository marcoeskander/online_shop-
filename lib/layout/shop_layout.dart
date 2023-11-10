import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/layout/cubit/cubitshop.dart';
import 'package:online_shop/layout/cubit/shoplstate.dart';
import 'package:online_shop/modules/search/sarch_s.dart';
import 'package:online_shop/shared/components/components.dart';
import 'package:online_shop/shared/manager/color_manager.dart';

class ShopLatyout extends StatelessWidget {
  const ShopLatyout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CubitShop()
        ..getHomeData()
        ..getCategorieData()
        ..getprofileData()
        ..getfavoretsData(),
      child: BlocConsumer<CubitShop, ShopState>(
          listener: (context, state) {},
          builder: (context, state) {
            var Cubit = CubitShop.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text(Cubit.title[Cubit.currentindex]),
                actions: [
                  IconButton(
                    onPressed: () {
                      navigatTo(context, search_screen());
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
              body: Cubit.bottomscreen[Cubit.currentindex],
              bottomNavigationBar: BottomNavigationBar(
                unselectedItemColor: ColorManager.grey,
                selectedItemColor: ColorManager.primary,
                onTap: (index) {
                  Cubit.changebottom(index);
                },
                currentIndex: Cubit.currentindex,
                // ignore: prefer_const_literals_to_create_immutables
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.apps),
                    label: 'category',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'favoret',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'settings',
                  ),
                ],
              ),
            );
          }),
    );
  }
}
