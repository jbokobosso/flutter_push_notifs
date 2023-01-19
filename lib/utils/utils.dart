import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Utils {
  static Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high
    );
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await FlutterLocalNotificationsPlugin().show(0, 'title', 'body', platformChannelSpecifics);
  }

}