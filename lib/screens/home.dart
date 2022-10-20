import 'package:flutter/material.dart';
import 'package:lect10_sample/services/local_notification_service.dart';
import 'SecondScreen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final NotificationService service;

  @override
  void initState() {
    service = NotificationService();
    service.initializePlatformNotifications();
    listenToNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications Sample')),
      body: SafeArea(
          child: Center(
              child: SizedBox(
        height: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await service.showNotification(
                      id: 0, title: 'Notification Title', body: 'Body Text');
                },
                child: const Text('Show Local Notif')),
            ElevatedButton(
                onPressed: () async {
                  await service.showScheduledNotification(
                      id: 1,
                      title: 'Notif title',
                      body: 'Body Text',
                      seconds: 4);
                },
                child: const Text('Show Scheduled Notif')),
            ElevatedButton(
                onPressed: () async {
                  await service.showNotificationWithPayload(
                      id: 2,
                      title: 'Notif title',
                      body: 'Body Text',
                      payload: 'Payload Navigation');
                },
                child: const Text('Show Notif with Payload'))
          ],
        ),
      ))),
    );
  }

  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      print('payload $payload');

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => SecondScreen(payload: payload))));
    }
  }
}
