import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifs/constants/core.dart';
import 'package:notifs/utils/utils.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFlutterLocalNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifs',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => Utils.showNotificationWithActions(DateTime.now().microsecond, "Santrinos Raphaël", "Drill love", CoreConstants.ARTWORK_URL),
            child: const Icon(Icons.music_note),
          ),
          FloatingActionButton(
            onPressed: () => Utils.showNotification(DateTime.now().microsecond, "Random", "Random time: ${DateTime.now().toIso8601String()}"),
            child: const Icon(Icons.notifications_active),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

initFlutterLocalNotifications() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveBackgroundNotificationResponse,
  );
}

onDidReceiveNotificationResponse(NotificationResponse notificationResponse) {
  print('notification response');
  print(notificationResponse);
}

onDidReceiveBackgroundNotificationResponse(NotificationResponse notificationResponse) {
  print('background notification response');
  print(notificationResponse);
}

