import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'models/Exam.dart';

class ExamDataSource extends CalendarDataSource {
  ExamDataSource(List<Exam> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    // TODO: implement getStartTime
    return appointments![index].date;
  }


  @override
  String? getNotes(int index) {
    // TODO: implement getNotes
    return appointments![index].title;
  }

  @override
  String getSubject(int index) {
    return appointments![index].title;
  }

  @override
  Color getColor(int index) {
    return Colors.primaries[Random().nextInt(18)];
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
