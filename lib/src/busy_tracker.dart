import 'dart:async';

import 'package:perspective/src/disposable.dart';
import 'package:perspective/src/stream_controlled_subject.dart';
import 'package:rxdart/rxdart.dart';

/// Tracks the busy state of a set of items, such as futures or streams.
/// It is recommnended to use an Enum as the key to track the itens. Otherwise,
/// the key must implement `==` and `hashCode`.
class BusyTracker<I>
    with StreamControlledSubject<Set<I>>
    implements Disposable {
  final _state = BehaviorSubject<Set<I>>.seeded({});

  /// Spins the tracker for the given `tracked` key.
  void spin(I tracked) {
    _state.add(_state.value..add(tracked));
  }

  /// Stops the tracker for the given `tracked` key.
  void stop(I tracked) {
    _state.add(_state.value..remove(tracked));
  }

  /// Returns a stream that emits `true` when the given `tracked` key is spun.
  Stream<bool> isSpun(I tracked) =>
      _state.map((state) => state.contains(tracked)).distinct();

  /// Returns a stream that emits `true` when any of the given `tracked` keys is spun.
  Stream<bool> isAnyOfSpun(Set<I> tracked) =>
      _state.map((state) => state.intersection(tracked).isNotEmpty).distinct();

  /// Returns a stream that emits `true` when any `tracked` key is spun.
  Stream<bool> isAnySpun() =>
      _state.map((state) => state.isNotEmpty).distinct();

  /// Returns a stream that emits `true` when all of the given `tracked` keys are spun.
  Stream<bool> isAllSpun(Set<I> tracked) =>
      _state.map((state) => state.containsAll(tracked)).distinct();

  @override
  void dispose() {
    _state.close();
  }

  @override
  StreamController<Set<I>> get controller => _state;
}

extension StreamBusyTracker<I> on Stream<I> {
  /// Facilitates the tracking of the stream using the given `busyTracker`.
  Stream<I> trackBusy(I tracked, BusyTracker<I> busyTracker) {
    return doOnError((_, __) => busyTracker.stop(tracked))
        .doOnCancel(() => busyTracker.stop(tracked))
        .doOnPause(() => busyTracker.stop(tracked))
        .doOnDone(() => busyTracker.stop(tracked))
        .doOnListen(() => busyTracker.spin(tracked))
        .doOnResume(() => busyTracker.spin(tracked));
  }
}
