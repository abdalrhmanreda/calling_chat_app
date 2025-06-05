// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
//
// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();
//
//   factory NotificationService() {
//     return _instance;
//   }
//
//   NotificationService._internal() {
//     _initializeNotifications();
//   }
//
//   void _initializeNotifications() {
//     AwesomeNotifications().initialize('resource://mipmap/ic_launcher', [
//       NotificationChannel(
//         channelKey: 'scheduled_channel',
//         channelName: 'Scheduled Notifications',
//         channelDescription: 'Notifications sent on a schedule',
//         defaultColor: const Color(0xFF9D50DD),
//         ledColor: Colors.white,
//         importance: NotificationImportance.High,
//         locked: true,
//       ),
//       NotificationChannel(
//         channelKey: 'adhan_channel',
//         channelName: 'Adhan Notifications',
//         channelDescription: 'Play adhan at prayer times',
//         defaultColor: const Color(0xFF9D50DD),
//         ledColor: Colors.white,
//         importance: NotificationImportance.Max,
//         locked: true,
//         defaultRingtoneType: DefaultRingtoneType.Notification,
//       ),
//     ], debug: true);
//   }
//
//   Future<void> requestPermissions() async {
//     bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isAllowed) {
//       await AwesomeNotifications().requestPermissionToSendNotifications();
//     }
//   }
//
//   Future<void> scheduleRepeatingNotification({required String body}) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 10,
//         channelKey: 'scheduled_channel',
//         title: 'وَذَكِّرْ فَإِنَّ الذِّكْرَىٰ تَنفَعُ الْمُؤْمِنِينَ',
//         body: body,
//         notificationLayout: NotificationLayout.Default,
//         displayOnBackground: true,
//         displayOnForeground: true,
//       ),
//       schedule: NotificationInterval(
//         interval: const Duration(minutes: 15),
//         // 15 minutes in seconds
//         timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//         repeats: true,
//         allowWhileIdle: true,
//         preciseAlarm: true,
//       ),
//     );
//   }
//
//   Future<void> sendNotification() async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 0,
//         // Ensure this ID is unique if used for multiple notifications
//         channelKey: 'scheduled_channel',
//         title: 'Hello',
//         body: 'This is a simple notification',
//         notificationLayout: NotificationLayout.Default,
//       ),
//     );
//   }
//
//   Future<void> scheduleAdhanNotification({
//     required String title,
//     required String body,
//     required DateTime scheduleTime,
//   }) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: createUniqueId(),
//         channelKey: 'adhan_channel',
//         title: title,
//         body: body,
//         customSound: 'assets/adhan/adhan.mp3',
//         notificationLayout: NotificationLayout.Default,
//         displayOnForeground: true,
//
//         displayOnBackground: true,
//         wakeUpScreen: true,
//         fullScreenIntent: true, // في حالة عايز الشاشة تفتح وقت الأذان
//       ),
//       schedule: NotificationCalendar(
//         year: scheduleTime.year,
//         month: scheduleTime.month,
//         day: scheduleTime.day,
//         hour: scheduleTime.hour,
//         minute: scheduleTime.minute,
//         second: 0,
//         millisecond: 0,
//         timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//         repeats: false,
//         preciseAlarm: true,
//       ),
//     );
//   }
//
//   int createUniqueId() =>
//       DateTime.now().millisecondsSinceEpoch.remainder(100000);
//
//   Future<void> cancelAllNotifications() async {
//     await AwesomeNotifications().cancelAll();
//   }
// }
//
// /*import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;
//
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest_all.dart' as tz;
// import 'dart:io';
//
// class NotificationService {
//   static final NotificationService _instance = NotificationService._internal();
//
//   factory NotificationService() {
//     return _instance;
//   }
//
//   NotificationService._internal() {
//     _initializeNotifications();
//   }
//
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   void _initializeNotifications() {
//     // إعدادات Android
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     // إعدادات التهيئة العامة
//     final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//
//     // تهيئة الإشعارات
//     _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         debugPrint('Notification Tapped: ${response.payload}');
//       },
//     );
//
//     tz.initializeTimeZones(); // لازم علشان تعمل الـ scheduling
//   }
//
//   // طلب إذن الإشعارات
//   Future<void> requestPermissions() async {
//     final bool? granted = await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>()
//         ?.requestNotificationsPermission();
//
//     if (granted != null && granted) {
//       debugPrint('Notifications permission granted');
//     } else {
//       debugPrint('Notifications permission denied');
//     }
//   }
//
//   // إرسال إشعار مباشر
//   Future<void> sendNotification() async {
//     await _flutterLocalNotificationsPlugin.show(
//       0,
//       'وَذَكِّرْ فَإِنَّ الذِّكْرَىٰ تَنفَعُ الْمُؤْمِنِينَ',
//       'This is a simple notification',
//       NotificationDetails(
//         android: _getAndroidNotificationDetails(),
//       ),
//     );
//   }
//
//   // جدولة إشعار متكرر
//   Future<void> scheduleRepeatingNotification({required String body}) async {
//     await _flutterLocalNotificationsPlugin.zonedSchedule(
//       10,
//       'وَذَكِّرْ فَإِنَّ الذِّكْرَىٰ تَنفَعُ الْمُؤْمِنِينَ',
//       body,
//       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), // أول إشعار بعد 5 ثواني
//       NotificationDetails(
//         android: _getAndroidNotificationDetails(),
//       ),
//       uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.time,
//       androidScheduleMode: AndroidScheduleMode.alarmClock, // التكرار
//     );
//   }
//
//   // إلغاء كل الإشعارات
//   Future<void> cancelAllNotifications() async {
//     await _flutterLocalNotificationsPlugin.cancelAll();
//   }
//
//   // إعدادات إشعارات Android
//   AndroidNotificationDetails _getAndroidNotificationDetails() {
//     return AndroidNotificationDetails(
//       'scheduled_channel', // ID القناة
//       'Scheduled Notifications', // اسم القناة
//       channelDescription: 'Notifications sent on a schedule',
//       importance: Importance.high,
//       priority: Priority.high,
//       playSound: true,
//       enableLights: true,
//       ledColor: const Color(0xFF9D50DD),
//       // حل مشكلة LED في الإصدارات الأقدم من Oreo
//       ledOnMs: Platform.isAndroid && (int.tryParse(Platform.version.split('.')[0]) ?? 0) < 8
//           ? 1000
//           : null,
//       ledOffMs: Platform.isAndroid && (int.tryParse(Platform.version.split('.')[0]) ?? 0) < 8
//           ? 500
//           : null,
//     );
//   }
// }
//
//
// * */
