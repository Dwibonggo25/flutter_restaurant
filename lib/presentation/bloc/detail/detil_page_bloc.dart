import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:submission2_flutter_expert/data/models/detil_restaurant_response.dart';
import 'package:submission2_flutter_expert/data/repositories/restaurant_repositories.dart';

part 'detil_page_event.dart';
part 'detil_page_state.dart';

class DetilPageBloc extends Bloc<DetilPageEvent, DetilPageState>{
  final RestaurantRepositories repositories;
  
  DetilPageBloc({@required this.repositories}): super(DetilPageInital());

  @override
  Stream<DetilPageState> mapEventToState(DetilPageEvent event)async* {
    if(event is DetilPageIn){
      yield* _getDetilRestaurant(event.idRestaurant);
    }
  }
  
  Stream<DetilPageState> _getDetilRestaurant(String id) async*{
    try{
      yield DetilPageLoading();
      var response = await repositories.getDetilRestaurant(id);
      if (response.error){
        yield DetilPageError(message: "Api Errror");
      }else{
        yield DetilPageHasData(data: response.restaurant);
      }
    }catch(e){
      print("Error nya dimari : ${e.toString()}");
      yield DetilPageError(message: "Terjadi error");
    }
  }
}