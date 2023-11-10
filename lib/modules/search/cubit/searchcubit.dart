import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop/models/saerchmodel.dart';
import 'package:online_shop/modules/search/cubit/searchstate.dart';
import 'package:online_shop/shared/components/constants.dart';
import 'package:online_shop/shared/network/endpoint.dart';
import 'package:online_shop/shared/network/remote/dio_helper.dart';

class sreachcubit extends Cubit<searchstate> {
  sreachcubit() : super(searchinitailstate());

  static sreachcubit get(context) => BlocProvider.of(context);
  SearchModel? searchmodel;

  void search({
    required String text,
  }) {
    emit(searchlodaingstate());
    DioHelperShop.postData(url: SEARCH, token: token, data: {'text': text})
        .then((value) {
      searchmodel = SearchModel.fromJson(value.data);
      emit(searchsucessstate());
    }).catchError((error) {
      emit(searcherrorstate());
    });
  }
}
