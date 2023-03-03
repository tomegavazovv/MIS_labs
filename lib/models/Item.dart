import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Item {
  Item({
    required this.name,
    required this.date,
    required this.time,
  });

  final String name;
  final DateTime date;
  final TimeOfDay time;
}