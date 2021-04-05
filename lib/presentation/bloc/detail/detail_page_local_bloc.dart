import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:submission2_flutter_expert/data/repositories/db/app_database.dart';
import 'package:submission2_flutter_expert/data/repositories/local/restaurant_local_datasource.dart';

part 'detail_page_local_event.dart';
part 'detail_page_local_state.dart';

class DetailLocalBloc extends Bloc<DetailLocalEvent, DetailLocalState> {
  final RestaurantLocalDatasource localDatasource;

  DetailLocalBloc({@required this.localDatasource}) : super (DetailLocalInital());

  @override
  Stream<DetailLocalState> mapEventToState(DetailLocalEvent event) async* {
    if(event is DetailLocalIn ){
      yield* _getDetailRestaurant(event.id);
    }
    if(event is SetDataFavorite){
      yield* _setDataInFavorite(event.data);
    }
  }

  Stream <DetailLocalState> _getDetailRestaurant(String data) async* {
    try{
      var result = await localDatasource.getDetailResturant(data);
      yield GetDetailSuccess(data: result);
      print("Error di: $data");
    }catch(e) {
      yield DetailLocalError(message: "Saya tidak tahu errornya");
      print("Error di: $e");
    }
  }

  Stream <DetailLocalState> _setDataInFavorite(RestaurantEntityData data) async* {
    try{
      await localDatasource.insertDataToFavorite(data);
      yield UpdateFavoriteSucccess();
      print("Error di: $data");
    }catch(e) {
      yield DetailLocalError(message: "Saya tidak tahu errornya");
      print("Error di: $e");
    }
  }
}

