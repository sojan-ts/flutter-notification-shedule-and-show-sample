import 'package:flutter/material.dart';
import 'package:flutter_local_notification/screens/second_screen.dart';
import 'package:flutter_local_notification/services/local_notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final LocalNotificationService service;

  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notification Test'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
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
                          id: 0,
                          title: 'Notification Title',
                          body: 'Some body');
                    },
                    child: const Text('Show Local Notification'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showScheduledNotification(
                          id: 0,
                          title: 'Hello dude',
                          body: 'Some body 1',
                          year: 2023,
                          month: 09,
                          day: 16,
                          hour: 13,
                          min: 16);
                    },
                    child: const Text('Show Scheduled Notification'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showScheduledNotification(
                          id: 1,
                          title: 'Notification Title 2',
                          body: 'Some body 2',
                          year: 2022,
                          month: 11,
                          day: 4,
                          hour: 15,
                          min: 44);
                    },
                    child: const Text('Show Scheduled Notification'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await service.showNotificationWithPayload(
                          id: 0,
                          title: 'Notification Title',
                          body: 'Some body',
                          payload: 'payload navigation');
                    },
                    child: const Text('Show Notification With Payload'),
                  ),
                  TextButton(
                      onPressed: () async {
                        await FlutterLocalNotificationsPlugin().cancel(0);
                      },
                      child: Text("Remove "))
                ],
              ),
            ),
          ),
        ),
      ),
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
