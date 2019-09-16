import 'notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override


  Future<void> _showNotification() async{
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel_id', 'channel_name', 'description', importance: Importance.Max, priority: Priority.High  , ticker: 'ticker');
    var IOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, IOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0, notifications.heads_up, notifications.notification, platformChannelSpecifics, payload:'item x');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(notifications.main_title),
      ),
      body: IconButton(
        icon: Icon(Icons.notifications),
        onPressed: () async{
        await _showNotification();
        },
          ),
    );
  }
}

