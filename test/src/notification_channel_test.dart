import 'package:flutter_test/flutter_test.dart';
import 'package:perspective/src/notification_channel.dart';

import 'utils.dart';

void main() {
  group('NotificationChannel', () {
    test('should notify listeners', () async {
      final channel = NotificationChannel<String>();
      final notifications = <String>[];

      channel
        ..listen(notifications.add)
        ..notify('Test Notification 1')
        ..notify('Test Notification 2');
      await tick();
      expect(notifications, ['Test Notification 1', 'Test Notification 2']);
    });

    test('should dispose correctly', () {
      final channel = NotificationChannel<String>();

      expect(channel.controller.isClosed, isFalse);
      channel.dispose();
      expect(channel.controller.isClosed, isTrue);
    });

    test('should not notify after dispose', () async {
      final channel = NotificationChannel<String>();
      final notifications = <String>[];

      channel
        ..listen(notifications.add)
        ..notify('Test Notification 1')
        ..dispose()
        ..notify('Test Notification 2');
      await tick();
      expect(notifications, ['Test Notification 1']);
    });

    test('should handle multiple listeners', () async {
      final channel = NotificationChannel<String>();
      final notifications1 = <String>[];
      final notifications2 = <String>[];

      channel
        ..listen(notifications1.add)
        ..listen(notifications2.add)
        ..notify('Test Notification');
      await tick();
      expect(notifications1, ['Test Notification']);
      expect(notifications2, ['Test Notification']);
    });
  });
}
