import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'ExamDataSource.dart';
import 'models/Exam.dart';

class Calendar extends StatefulWidget {
  final List<Exam> exams;

  const Calendar({Key? key, required this.exams}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: SfCalendar(
        view: CalendarView.month,
        backgroundColor: Colors.white38,
        dataSource: ExamDataSource(widget.exams),
        appointmentTextStyle: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        showNavigationArrow: true,
        monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
          showAgenda: true,
          showTrailingAndLeadingDates: true,
          agendaViewHeight: 50,
          agendaItemHeight: 40,
          appointmentDisplayCount: 1,
          agendaStyle: AgendaStyle(
            backgroundColor: Colors.white,
          ),
        ),
        onViewChanged: (ViewChangedDetails details) {
          final events = widget.exams.where((exam) =>
              exam.date.isAfter(
                  details.visibleDates.first.add(Duration(days: -1))) &&
              exam.date
                  .isBefore(details.visibleDates.last.add(Duration(days: 1))));

          final todayEvents = events.where((event) =>
              event.date.year == DateTime.now().year &&
              event.date.month == DateTime.now().month &&
              event.date.day == DateTime.now().day);

          if (todayEvents.isNotEmpty) {
            AndroidNotificationDetails androidPlatformChannelSpecifics =
                AndroidNotificationDetails(
              'channel id',
              'channel name',
              additionalFlags: Int32List.fromList(<int>[4]),
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker',
              playSound: true,
              color: Colors.greenAccent,
              enableLights: true,
              enableVibration: true,
              channelShowBadge: true,
              channelAction: AndroidNotificationChannelAction.createIfNotExists,
              visibility: NotificationVisibility.public,
              fullScreenIntent: true,
              ongoing: true,
              autoCancel: true,
              onlyAlertOnce: true,
              timeoutAfter: 10000,
              groupKey: 'Group Key',
              groupAlertBehavior: GroupAlertBehavior.all,
              setAsGroupSummary: true,
              showWhen: true,
            );

            NotificationDetails platformChannelSpecifics =
                NotificationDetails(android: androidPlatformChannelSpecifics);

            flutterLocalNotificationsPlugin.show(0, 'Today\'s Exams',
                'You have exams scheduled for today', platformChannelSpecifics);
          }
        },
      ),
    );
  }
}
