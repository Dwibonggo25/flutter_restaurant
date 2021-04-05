import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:submission2_flutter_expert/data/repositories/db/app_database.dart';
import 'package:submission2_flutter_expert/data/repositories/local/restaurant_local_datasource.dart';

part 'favorite_local_event.dart';
part 'favorite_local_state.dart';

class FavoriteLocalBloc extends Bloc<FavoriteLocalEvent, FavoriteLocalState> {
  final RestaurantLocalDatasource localDatasource;

  FavoriteLocalBloc({@required this.localDatasource}) : super (FavoriteLocalInital());

  @override
  Stream<FavoriteLocalState> mapEventToState(FavoriteLocalEvent event) async* {
    if(event is FavoriteLocalIn ){
      yield* _getDatFavorite();
    }
    if (event is DeleteFavorite) {
      yield* _updateFavorite(event.id);
    }
  }

  Stream <FavoriteLocalState> _getDatFavorite() async* {
    try{
      yield FavoriteLocalInital();
      var result = await localDatasource.getAllDataFavorite();
      print("Kemana nih $result");
      if(result.isEmpty){
        yield FavoriteLocalNoData(message: "Favorite kosong");
        return;
      }
      yield FavoriteLocalHasData(data: result);
    }catch(e) {
      yield FavoriteLocalError(message: "Kaga tau datanya kemana");
    }
  }

  Stream <FavoriteLocalState> _updateFavorite(String id)  async*{
    try{
      await localDatasource.updateFavorite(id);
      yield UpdateLocalSuccess();
    }
    catch(e) {
      yield FavoriteLocalError(message: "Kaga tau datanya kemana");
    }
  }


}

