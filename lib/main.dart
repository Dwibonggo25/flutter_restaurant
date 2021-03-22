
import 'package:submission2_flutter_expert/data/repositories/restaurant_repositories.dart';
import 'package:submission2_flutter_expert/presentation/bloc/detail/detil_page_bloc.dart';
import 'package:submission2_flutter_expert/presentation/bloc/home/home_page_bloc.dart';
import 'package:submission2_flutter_expert/presentation/ui/detail_restaurant_screen.dart';
import 'package:submission2_flutter_expert/presentation/ui/home.dart';
import 'package:submission2_flutter_expert/shared/bloc/restaurant_bloc_observer.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = RestaurantBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => HomePageBloc(repositories: RestaurantRepositories())),
        BlocProvider(create: (context) => DetilPageBloc(repositories: RestaurantRepositories())),
      ],
      child: MaterialApp(
        initialRoute: HomePageScreen.routeName,
        routes: {
          HomePageScreen.routeName: (context) => HomePageScreen(),
          DetailResturantScreen.routeName: (context) => DetailResturantScreen( args: ModalRoute.of(context).settings.arguments,),
        }
      ),
    );
  }
}
