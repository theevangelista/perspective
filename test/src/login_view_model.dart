import 'dart:async';

import 'package:perspective/src/busy_tracker.dart';
import 'package:perspective/src/notification_channel.dart';
import 'package:perspective/src/view_model.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends ViewModel {
  final notifications = NotificationChannel<String>();
  final busyTracker = BusyTracker<String>();

  final username = PublishSubject<Field<String>>();
  final password = PublishSubject<Field<String>>();
  final rememberMe = PublishSubject<bool>();

  @override
  void onInit() {
    // how to run validations?
  }

  void onUsernameChange(String newValue) {
   // TODO implement
  }

  @override
  List<StreamController<dynamic>> get resources => [
        notifications,
        busyTracker,
        username,
        password,
        rememberMe,
      ];
}

class Field<T> {
  const Field({required this.value, this.error});
  final T value;
  final String? error;
}
