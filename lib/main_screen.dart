import 'package:flutter/material.dart';
import 'package:submission2_flutter_expert/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:submission2_flutter_expert/presentation/ui/detail_restaurant_screen.dart';
import 'package:submission2_flutter_expert/presentation/ui/favorite_screen.dart';
import 'package:submission2_flutter_expert/presentation/ui/home.dart';
import 'package:submission2_flutter_expert/presentation/ui/setting_screen.dart';
import 'package:submission2_flutter_expert/shared/helper/background_service.dart';
import 'package:submission2_flutter_expert/shared/helper/notification_helper.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  BottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _service.someTask());
    _notificationHelper.configureSelectNotificationSubject(
        DetailResturantScreen.routeName);
    _bottomNavBarBloc = BottomNavBarBloc();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot){
            switch(snapshot.data){
              case NavBarItem.HOME:
                return _homeArea();
              case NavBarItem.FAVORITE:
                return _alertArea();
              case NavBarItem.SETTINGS:
                return _settingsArea();
            }
          },
      ),
      bottomNavigationBar: StreamBuilder(
        stream: _bottomNavBarBloc.itemStream,
        initialData: _bottomNavBarBloc.defaultItem,
        builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
          return BottomNavigationBar(
            fixedColor: Colors.blueAccent,
            currentIndex: snapshot.data.index,
            onTap: _bottomNavBarBloc.pickItem,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Favorite',
                icon: Icon(Icons.favorite),
              ),
              BottomNavigationBarItem(
                label: 'Setting',
                icon: Icon(Icons.settings),
              ),
            ],
          );
        },
      ),
    );
  }

   Widget _homeArea() {
    return HomePageScreen();
  }

  Widget _alertArea() {
    return FavoriteScreen();
  }

  Widget _settingsArea() {
    return SettingScreen();
  }
}
