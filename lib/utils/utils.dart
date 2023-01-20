import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifs/constants/core.dart';
import 'package:path_provider/path_provider.dart';

class Utils {

  static Future<String> downloadAndSaveFile(String url) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/${DateTime.now().microsecond}';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static Future<void> showNotification(int id, String title, String description) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        CoreConstants.NOTIFICATION_CHANNEL_ID,
        CoreConstants.NOTIFICATION_CHANNEL_NAME,
        importance: Importance.max,
        priority: Priority.high
    );
    var notificationDetails = NotificationDetails(android: androidPlatformChannelSpecifics);
    await FlutterLocalNotificationsPlugin().show(id, title, description, notificationDetails);
  }

  static Future<void> showNotificationWithActions(int id, String title, String description, String iconUrl) async {
    String artworkImage = await Utils.downloadAndSaveFile(iconUrl);
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      CoreConstants.NOTIFICATION_CHANNEL_ID,
      CoreConstants.NOTIFICATION_CHANNEL_NAME,
      largeIcon: DrawableResourceAndroidBitmap('rewind'),
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(DateTime.now().toString(), 'Action 1', icon: DrawableResourceAndroidBitmap('rewind')),
        AndroidNotificationAction(DateTime.now().toString(), 'Action 2', icon: DrawableResourceAndroidBitmap('pause')),
        AndroidNotificationAction(DateTime.now().toString(), 'Action 3', icon: DrawableResourceAndroidBitmap("forward")),
      ],
    );
    NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails);
    await FlutterLocalNotificationsPlugin().show(0, title, description, notificationDetails);
  }


}