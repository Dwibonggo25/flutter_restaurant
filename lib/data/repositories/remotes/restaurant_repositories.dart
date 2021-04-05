
import 'package:submission2_flutter_expert/data/models/detil_restaurant_response.dart';
import 'package:submission2_flutter_expert/data/models/restaurant_response.dart';
import 'package:dio/dio.dart';
import 'package:submission2_flutter_expert/data/models/search_response.dart';

class RestaurantRepositories {
  var dio = Dio();
  static final String _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<RestaurantResponse> getALlRestaurant() async{
    Response response = await dio.get(_baseUrl+"/list");
    return RestaurantResponse.fromJson(response.data);
  }
  
  Future<SearchRestaurantResponse> getSearchDataRestaurant(String query) async {
    Response response = await dio.get(_baseUrl+"/search?q=$query");
    return SearchRestaurantResponse.fromJson(response.data);
  }

  Future<DetilRestaurantResponse> getDetilRestaurant(String id) async {
    Response response = await dio.get(_baseUrl+"detail/$id");
    return DetilRestaurantResponse.fromJson(response.data);
  }
}