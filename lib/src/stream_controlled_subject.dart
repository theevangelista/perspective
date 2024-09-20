import 'dart:async';

import 'package:flutter/foundation.dart';

mixin StreamControlledSubject<T> implements StreamController<T> {
  @visibleForOverriding
  StreamController<T> get controller;

  @override
  @visibleForOverriding
  void add(T event) {
    controller.sink.add(event);
  }

  @override
  @visibleForOverriding
  void addError(Object error, [StackTrace? stackTrace]) {
    controller.sink.addError(error, stackTrace);
  }

  @override
  @visibleForOverriding
  Future<void> addStream(Stream<T> source, {bool? cancelOnError}) {
    return controller.addStream(source, cancelOnError: cancelOnError);
  }

  @override
  @visibleForOverriding
  Future<void> close() {
    return controller.close();
  }

  @override
  @visibleForOverriding
  Future<void> get done => controller.done;

  @override
  @visibleForOverriding
  bool get hasListener => controller.hasListener;

  @override
  bool get isClosed => controller.isClosed;

  @override
  @visibleForOverriding
  bool get isPaused => controller.isPaused;

  @override
  @visibleForOverriding
  StreamSink<T> get sink => controller.sink;

  @override
  @visibleForOverriding
  Stream<T> get stream => controller.stream;

  @override
  @visibleForOverriding
  FutureOr<void> Function()? onCancel = () {};

  @override
  @visibleForOverriding
  void Function()? onListen = () {};

  @override
  @visibleForOverriding
  void Function()? onPause = () {};

  @override
  @visibleForOverriding
  void Function()? onResume = () {};
}
