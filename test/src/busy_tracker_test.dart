
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:perspective/src/busy_tracker.dart';

class MockStreamController extends Mock implements BusyTracker<String> {}

void main() {
  group('BusyTracker', () {
    late BusyTracker<String> busyTracker;

    setUp(() {
      busyTracker = BusyTracker<String>();
    });

    tearDown(() {
      busyTracker.dispose();
    });

    test('initial state is false for anything', () {
      expect(busyTracker.isSpun('any'), emits(false));
      expect(busyTracker.isAnyOfSpun({'any'}), emits(false));
      expect(busyTracker.isAnySpun(), emits(false));
      expect(busyTracker.isAllSpun({'any'}), emits(false));
    });

    test('stop removes a tracked item', () {
      const tracked = 'task1';
      busyTracker.spin(tracked);
      busyTracker.stop(tracked);
      expect(busyTracker.isSpun(tracked), emits(false));
    });

    test('isSpun emits true when item is spun', () {
      const tracked = 'task1';
      busyTracker.spin(tracked);
      expect(busyTracker.isSpun(tracked), emits(true));
    });

    test('isAnyOfSpun emits true when any of the items are spun', () {
      const tracked = 'task1';
      const tracked2 = 'task2';
      busyTracker.spin(tracked);
      busyTracker.stop(tracked);
      busyTracker.spin(tracked2);
      expect(busyTracker.isAnyOfSpun({tracked, tracked2}), emits(true));
    });

    test('isAnySpun emits true when any item is spun', () {
      const tracked = 'task1';
      const tracked2 = 'task2';
      const tracked3 = 'task3';
      busyTracker.spin(tracked);
      [tracked2, tracked3]
        ..forEach(busyTracker.spin)
        ..forEach(busyTracker.stop);
      expect(busyTracker.isAnySpun(), emits(true));
    });

    test('isAllSpun emits true when all items are spun', () {
      const tracked = 'task1';
      const tracked2 = 'task2';
      busyTracker.spin(tracked);
      busyTracker.spin(tracked2);

      expect(busyTracker.isAllSpun({tracked, tracked2}), emits(true));
    });
  });
}
