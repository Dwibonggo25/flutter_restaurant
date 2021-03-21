import 'package:flutter/material.dart';
import 'package:submission2_flutter_expert/presentation/ui/home.dart';
import 'package:submission2_flutter_expert/shared/conts.dart';

class Router{
  static Route<dynamic> generateRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case AuthRestaurant:
        return MaterialPageRoute(builder: (_) => HomePageScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomePageScreen());
    }
  }
}