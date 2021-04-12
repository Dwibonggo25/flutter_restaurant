
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission2_flutter_expert/data/prefences/prefences_helper.dart';
import 'package:submission2_flutter_expert/shared/helper/background_service.dart';
import 'package:submission2_flutter_expert/shared/helper/date_time_picker_helper.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final PreferencesHelper preferences;

  NotificationBloc({@required this.preferences}) : super(NotificationInit());

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is SetNotificationEvent) {
      try {
        bool _isScheduled = await preferences.getAlarmActive;
        print('Scheduled :  $_isScheduled');
        if(_isScheduled){
          await AndroidAlarmManager.periodic(
            Duration(hours: 24),
            1,
            BackgroundService.callback,
            startAt: DateTimeHelper.format(),
            exact: true,
            wakeup: true,
          );
          yield SuccessSetNotification();
        }else{
          await AndroidAlarmManager.cancel(1);
          yield SuccessSetNotification();
        }
      }  catch (e) {
        print('Error notif :  ${e.toString()}');
        yield FailedSetNotification(error: e.toString());
      }
    }
  }
}