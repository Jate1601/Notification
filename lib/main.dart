import 'package:flutter/rendering.dart';

import 'notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';  // For heads-up notificaions

void main() => runApp(new MaterialApp(home: new MyApp()));

class MyApp extends StatefulWidget{
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override

  void initState(){
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new  AndroidInitializationSettings('@mipmap/ic_launcher');
    var IOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android, IOS);
    flutterLocalNotificationsPlugin.initialize(initSettings);
  }
  Future<void> initSettings(String payload){
    debugPrint("payload: $payload");
    showDialog(context: context, builder: (_)=> new AlertDialog(
      title: Text('Notification'),
      content: Text('Payload'),
    ));
  }


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
    debugPaintSizeEnabled = true;
    return Scaffold(
      appBar: new AppBar(
        title: Text(notifications.main_title),
      ),
      body:Center(
      child:Column(children: <Widget>[
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () async{
            await _showNotification();
          },
        ),

        FloatingActionButton(
          child: Icon(Icons.notifications),
          onPressed: () async{
            await _showNotification();
          },
        )

      ],
        ),
      ),
    );
  }
}

