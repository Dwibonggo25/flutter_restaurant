
import 'package:submission2_flutter_expert/data/models/restaurant_response.dart';
import 'package:dio/dio.dart';

class RestaurantRepositories {
  var dio = Dio();
  static final String _baseUrl = "https://restaurant-api.dicoding.dev/";

  Future<RestaurantResponse> getALlRestaurant() async{
    Response response = await dio.get(_baseUrl+"/list");
    return RestaurantResponse.fromJson(response.data);
  }

}