

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission2_flutter_expert/data/prefences/prefences_helper.dart';
import 'package:submission2_flutter_expert/presentation/bloc/notification/notification_bloc.dart';
import 'package:submission2_flutter_expert/presentation/widget/platform_widget.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/setting_page';
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool _settAlarm = false;

  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  PreferencesHelper _preferences;

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    _initAlarm();
  }

  void _initAlarm() async {
    sharedPreferences =  await SharedPreferences.getInstance();
    _preferences = PreferencesHelper(sharedPreferences: sharedPreferences);
    _preferences.getAlarmActive.then((value) {
      setState(() {
        _settAlarm = value;
      });
    } );
  }

  Widget _buildBody (BuildContext context){
    return BlocListener<NotificationBloc, NotificationState>(
        listener: (context, state){
          print('State notif kesnii :  $state');
          if(state is SuccessSetNotification){
            _scaffoldGlobalKey.currentState.showSnackBar(SnackBar(
              duration: Duration(seconds: 2),
              content: Text("Alarm di setting"),
              backgroundColor: Colors.green,
            ));
          }
          if(state is FailedSetNotification){
            _scaffoldGlobalKey.currentState.showSnackBar(SnackBar(
              duration: Duration(seconds: 2),
              content: Text("Error"),
              backgroundColor: Colors.green,
            ));
          }
        },
      child: Scaffold(
        key: _scaffoldGlobalKey,
        appBar: AppBar(
          title: Text(
            'Setting',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                    child: Text(
                      'Alarm',
                      style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    ),
                  ),
                  Switch.adaptive(
                      value: _settAlarm,
                      onChanged: (value) async{
                        await _preferences.setAlarmActive(value);
                        setState(() {
                          _settAlarm = value;
                          context.read<NotificationBloc>().add(SetNotificationEvent());
                        });
                      })
                ],
              )
            ],
          ),
        ),
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Setting"),
      ),
      child: _buildBody(context),
    );
  }
}



