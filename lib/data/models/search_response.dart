import 'package:submission2_flutter_expert/data/models/restaurant_response.dart';

class SearchRestaurantResponse {
  SearchRestaurantResponse({
    this.error,
    this.founded,
    this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurant> restaurants;

  factory SearchRestaurantResponse.fromJson(Map<String, dynamic> json) => SearchRestaurantResponse(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

}
