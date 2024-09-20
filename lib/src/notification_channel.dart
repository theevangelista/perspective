import 'dart:async';

import 'package:perspective/src/disposable.dart';
import 'package:perspective/src/stream_controlled_subject.dart';
import 'package:rxdart/rxdart.dart';


class NotificationChannel<N>
    with StreamControlledSubject<N>
    implements Disposable {
  final _channel = BehaviorSubject<N>();

  void listen(void Function(N) onNotification) {
    _channel.listen(onNotification);
  }

  void notify(N notification) {
    if (isClosed) return;
    _channel.sink.add(notification);
  }

  @override
  void dispose() {
    _channel.close();
  }

  @override
  StreamController<N> get controller => _channel;
}
