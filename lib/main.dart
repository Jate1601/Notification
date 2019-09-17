import 'package:flutter/rendering.dart';

import 'notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // For heads-up notificaions

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, IOS);
    flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> initSettings(String payload) {
    debugPrint("payload: $payload");
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: Text('Notification'),
              content: Text('Payload'),
            ));
  }

  Future<void> _showNotification(int ID, String title, String payload_text) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_id', 'channel_name', 'description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var IOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, IOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        ID, title, payload_text, platformChannelSpecifics,
        payload: 'item x');
  }

  @override
  Widget build(BuildContext context) {
    //debugPaintSizeEnabled = true;
    return Scaffold(
      appBar: new AppBar(
        title: Text(notifications.main_title),
      ),

      bottomNavigationBar: BottomAppBar(
          child: Container(
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () async {
                    //await _showNotification();
                    await _showNotification(notifications.counter,"Icon Left", "You drank enough water");
                    notifications.counter += 1;
                  },
                ),
                IconButton(
                  icon: Icon(Icons.airport_shuttle),
                  onPressed: () async {
                    var temp = notifications.counter;
                    await _showNotification(notifications.counter,"Icon Right", "Time to drink your : $temp");
                    notifications.counter += 1;
                  },
                )
              ],
            ),
              color: Colors.blueAccent,
      )),
    );
  }
}
