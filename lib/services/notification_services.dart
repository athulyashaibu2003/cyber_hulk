import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cyber_hulk/model/news_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class NotificationServices {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('ic_launcher');

    var initialisationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await notificationsPlugin.initialize(
      initialisationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {},
    );

    await requestNotificationPermission();
  }

  Future<void> requestNotificationPermission() async {
    // Await the status check before calling .isDenied
    var status = await Permission.notification.status;

    if (status.isDenied) {
      await Permission.notification.request();
    }
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          icon: 'ic_launcher', importance: Importance.max),
    );
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
  }) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}

NewsModel newsModel = NewsModel();
int length = 0;

class ServerPollingService {
  Timer? _timer;
  final NotificationServices notificationServices = NotificationServices();

  Future<void> startPolling() async {
    // Set up a periodic timer to poll the server every 10 seconds
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await checkForNewData();
    });
  }

  Future<void> checkForNewData() async {
    try {
      length = newsModel.list?.length ?? 0;
      final res = await http.get(
          Uri.parse('https://cybot.avanzosolutions.in/cybot/newsdisplay.php'));
      // var res = await http.get(Uri.parse(url));
      var json = jsonDecode(res.body) as Map<String, dynamic>;
      newsModel = NewsModel.fromJson(json);
      log(newsModel.list?[length].filename ?? "");
      if (res.statusCode == 200) {
        // final data = json.decode(res.body);
        if (newsModel.list!.length > length) {
          // Show notification when new data is found
          await notificationServices.showNotification(
            title: newsModel.list?[length - 1].filename,
            body: newsModel.list?[length - 1].cont,
          );
        }
      } else {
        print('Failed to check for new data');
      }
    } catch (error) {
      print('Error while polling server: $error');
    }
  }

  void stopPolling() {
    _timer?.cancel();
  }
}
