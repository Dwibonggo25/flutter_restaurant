
import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission2_flutter_expert/data/prefences/prefences_helper.dart';
import 'package:submission2_flutter_expert/data/repositories/db/app_database.dart';
import 'package:submission2_flutter_expert/data/repositories/local/restaurant_local_datasource.dart';
import 'package:submission2_flutter_expert/data/repositories/remotes/restaurant_repositories.dart';
import 'package:submission2_flutter_expert/main_screen.dart';
import 'package:submission2_flutter_expert/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:submission2_flutter_expert/presentation/bloc/detail/detail_page_local_bloc.dart';
import 'package:submission2_flutter_expert/presentation/bloc/detail/detil_page_bloc.dart';
import 'package:submission2_flutter_expert/presentation/bloc/favorite/favorite_local_bloc.dart';
import 'package:submission2_flutter_expert/presentation/bloc/home/home_local_bloc.dart';
import 'package:submission2_flutter_expert/presentation/bloc/home/home_page_bloc.dart';
import 'package:submission2_flutter_expert/presentation/bloc/notification/notification_bloc.dart';
import 'package:submission2_flutter_expert/presentation/ui/detail_restaurant_screen.dart';
import 'package:submission2_flutter_expert/presentation/ui/favorite_screen.dart';
import 'package:submission2_flutter_expert/presentation/ui/home.dart';
import 'package:submission2_flutter_expert/presentation/ui/setting_screen.dart';
import 'package:submission2_flutter_expert/shared/bloc/restaurant_bloc_observer.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission2_flutter_expert/shared/helper/background_service.dart';
import 'package:submission2_flutter_expert/shared/helper/navigation.dart';
import 'package:submission2_flutter_expert/shared/helper/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  Bloc.observer = RestaurantBlocObserver();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {

  RestaurantLocalDatasource _localDatasource = RestaurantLocalDatasourceImpl(appDatabase: AppDatabase());
  PreferencesHelper _preferences;
  SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomePageBloc(repositories: RestaurantRepositories())),
        BlocProvider(create: (context) => DetilPageBloc(repositories: RestaurantRepositories())),
        BlocProvider(create: (context) => HomeLocalBloc(localDatasource: _localDatasource)),
        BlocProvider(create: (context) => FavoriteLocalBloc(localDatasource: _localDatasource)),
        BlocProvider(create: (context) => DetailLocalBloc(localDatasource: _localDatasource)),
        BlocProvider(create: (context) => NotificationBloc(preferences: _preferences)),

      ],
      child: MaterialApp(
          navigatorKey: navigatorKey,
        initialRoute: MainScreen.routeName,
        routes: {
          MainScreen.routeName : (context) => MainScreen(),
          HomePageScreen.routeName: (context) => HomePageScreen(),
          SettingScreen.routeName: (context) => SettingScreen(),
          FavoriteScreen.routeName : (context) => FavoriteScreen(),
          DetailResturantScreen.routeName: (context) => DetailResturantScreen( args: ModalRoute.of(context).settings.arguments,),
        }
      ),
    );
  }
}
