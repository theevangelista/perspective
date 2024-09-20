import 'dart:async';

import 'package:perspective/perspective.dart';
import 'package:rxdart/rxdart.dart';

class FormViewModel extends ViewModel {
  final email = PublishSubject<String>();
  final password = PublishSubject<String>();
  final confirmPassword = PublishSubject<String>();
  final passwordsMatch = PublishSubject<bool>();
  final obscurePassword = PublishSubject<bool>();

  @override
  void onInit() {
    super.onInit();
    matchPasswords();
  }

  void matchPasswords() {
    Rx.combineLatest2(password, confirmPassword, (p, cp) => p == cp)
        .listen(passwordsMatch.sink.add);
  }

  void toggleObscurePassword() {
    obscurePassword.first.then((value) => obscurePassword.sink.add(!value));
  }

  @override
  List<StreamController> get resources => [
        email,
        password,
        confirmPassword,
        passwordsMatch,
        obscurePassword,
      ];
}
