
import 'package:submission2_flutter_expert/data/repositories/restaurant_repositories.dart';
import 'package:submission2_flutter_expert/presentation/bloc/home_page_bloc.dart';
import 'package:submission2_flutter_expert/presentation/ui/home.dart';
import 'package:submission2_flutter_expert/shared/bloc/restaurant_bloc_observer.dart';
import 'package:submission2_flutter_expert/shared/conts.dart';
import 'package:submission2_flutter_expert/shared/router.dart';
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
    return BlocProvider(
      create: (context) => HomePageBloc(repositories: RestaurantRepositories()),
      child: MaterialApp(
        title: 'Fetch Data Example',
        home: HomePageScreen(),
      ),
    );
  }
}
