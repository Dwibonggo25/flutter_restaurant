import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:submission2_flutter_expert/data/repositories/db/app_database.dart';
import 'package:submission2_flutter_expert/data/repositories/local/restaurant_local_datasource.dart';

part 'home_local_event.dart';
part 'home_local_state.dart';

class HomeLocalBloc extends Bloc<HomeLocalEvent, HomeLocalState> {
  final RestaurantLocalDatasource localDatasource;

  HomeLocalBloc({@required this.localDatasource}) : super (HomeLocalInital());

  @override
  Stream<HomeLocalState> mapEventToState(HomeLocalEvent event) async* {
    if(event is InsertIn ){
      yield* _insertToFavorite(event.data);
    }
  }

  Stream <HomeLocalState> _insertToFavorite(RestaurantEntityData data) async* {
    try{
      localDatasource.insertDataToFavorite(data);
      yield UpdateFavoriteSucccess();
    }catch(e) {
      yield HomeLocalError(message: "Saya tidak tahu errornya");
      print("Error di: $e");
    }
  }

}

