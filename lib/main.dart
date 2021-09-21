import 'dart:io';
import 'package:e_canada/credit/SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'GlobalUtility.dart';
import 'credit/LoanItems.dart';
import 'credit/LoginPage.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  getSessionId();
}



class SplashPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

}
class _MyAppState extends State<SplashPage> {
  String firebaseToken="";
@override
  void initState() {
  getFcmToken();
/*  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');

   *//* Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );*//*
    checkNotification(message);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  });
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);*/


  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    checkNotification(message);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {});
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: (strSession =="" || strSession == "null" || strSession == null ) ? LoginPage():LoanItems("$strSession"),
        debugShowCheckedModeBanner: false);
  }


//background
  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");

    /*Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );*/

  }
  void showNotification(String title, String body) async {
    debugPrint("show notification method called");

    FlutterLocalNotificationsPlugin fltNotification =
    FlutterLocalNotificationsPlugin();

    var androiInit = AndroidInitializationSettings('mipmap/ic_launcher');

    var iosInit = IOSInitializationSettings();

    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    fltNotification.initialize(initSetting);

    var androidDetails = AndroidNotificationDetails(
        '1', 'channelName', 'channel Description',
        importance: Importance.high, priority: Priority.high);
    var iosDetails = IOSNotificationDetails(
        sound: '', presentAlert: true, presentBadge: true, presentSound: true);
    var generalNotificationDetails =
    NotificationDetails(android: androidDetails, iOS: iosDetails);

    await fltNotification.show(0, title, body, generalNotificationDetails,
        payload: 'Notification');

  }

checkNotification(RemoteMessage message) {
  print(' default Message data: ${message.data}');


  if (message.data != null && message.data.isNotEmpty) {
    // in case of backend
    print('Message data: ${message.data}');
    print('Message title: ' + message.data['title'].toString());
    print('Message body: ${message.data['body'].toString()}');
    showNotification(
        message.data['title'].toString(), message.data['body'].toString());
  } else {
    // in case of firebase
    print('Message notification : ${message.notification}');
    print('Message title: ' + message.notification.title);
    print('Message body: ${message.notification.body}');
    showNotification(message.notification.title, message.notification.body);
  }
}
getFcmToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String token = await messaging.getToken(
  );
  firebaseToken = token;
  debugPrint("Fcm_token:" + firebaseToken);
  GlobalUtility().setFcmToken(firebaseToken);

}
}


String strSession;
void getSessionId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  strSession=  prefs.getString('sessionId').toString();
  debugPrint("session sessionId= $strSession" );
  runApp(SplashPage() );
}






