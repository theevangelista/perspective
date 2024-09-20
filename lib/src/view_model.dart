import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:perspective/src/disposable.dart';

abstract class ViewModel implements Disposable {
  /// Aftr the view model is created, this method is called.
  void onInit() {}

  @visibleForOverriding
  List<StreamController<dynamic>> get resources;

  /// Disposes of this view model and releases resources.
  @override
  void dispose() {
    for (final controller in resources) {
      controller.close();
    }
  }
}
