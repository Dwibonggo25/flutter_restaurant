import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:submission2_flutter_expert/data/models/restaurant_response.dart';
import 'package:submission2_flutter_expert/data/repositories/remotes/restaurant_repositories.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final RestaurantRepositories repositories;

  HomePageBloc({@required this.repositories}) : super (HomePageInital());

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if(event is HomePageIn ){
      yield* _getAllRestaurant();
    }
    if(event is SearchPageIn){
      yield* _getSearchDataRestaurant(event.query);
    }
  }

  Stream<HomePageState>  _getAllRestaurant() async* {
    try{
      yield HomePageLoading();
      var response = await repositories.getALlRestaurant();
      if (response.restaurants.isEmpty){
        yield HomePageNoData(message: "Empty data");
      }else {
        yield HomePageHasData(data: response.restaurants);
      }
    }catch(e) {
      yield HomePageError(message: "Saya tidak tahu errornya dimana");
    }
  }

  Stream<HomePageState> _getSearchDataRestaurant(String query) async*{
    try{
      yield HomePageLoading();
      var response = await repositories.getSearchDataRestaurant(query);
      if (response.restaurants.isEmpty){
        yield HomePageNoData(message: "Empty data");
      }else{
        yield HomePageHasData(data: response.restaurants);
      }
    }catch(e){
      yield HomePageError(message: "Saya tidak tahu errornya dimana");
    }
  }
}