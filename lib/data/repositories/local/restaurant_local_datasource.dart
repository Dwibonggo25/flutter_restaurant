
import 'package:flutter/material.dart';
import 'package:submission2_flutter_expert/data/repositories/db/app_database.dart';

abstract class RestaurantLocalDatasource {
  Future insertDataToFavorite (RestaurantEntityData data);
  Future <List<RestaurantEntityData>>getAllDataFavorite();
  Future updateFavorite (String id);
  Future <RestaurantEntityData>getDetailResturant(String id);
}

class RestaurantLocalDatasourceImpl extends RestaurantLocalDatasource {
  final AppDatabase appDatabase;

  RestaurantLocalDatasourceImpl({@required this.appDatabase});

  @override
  Future insertDataToFavorite(RestaurantEntityData data)async {
    var dataFavorite = RestaurantEntityData(id: data.id, name: data.name, description: data.description, pictureId: data.pictureId, city: data.city,rating: data.rating, isFavorite: data.isFavorite);
    await appDatabase.restaurantDao.insertDataToFavorite(dataFavorite);
  }

  @override
  Future<List<RestaurantEntityData>> getAllDataFavorite() async {
    return await appDatabase.restaurantDao.getAllFavoriteLocal();
  }

  @override
  Future updateFavorite(String id) async{
    return await appDatabase.restaurantDao.updateFavorite(id);
  }

  @override
  Future<RestaurantEntityData> getDetailResturant(String id)async {
    var result = await appDatabase.restaurantDao.getDetailRestaurant(id);
    if(result.isFavorite == null){
      return RestaurantEntityData(id: result.id, name: result.name, description: result.description, pictureId: result.pictureId, city: result.city, rating: result.rating, isFavorite: false);
    }
    return result;
  }
}