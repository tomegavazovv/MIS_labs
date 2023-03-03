import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef DeleteExamTypeDef = void Function(String);

class ExamTile extends StatelessWidget {
  final String title;
  final DateTime dateTime;
  final DeleteExamTypeDef deleteExam;

  const ExamTile({
    Key? key,
    required this.title,
    required this.dateTime,
    required this.deleteExam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.access_time_filled,
        semanticLabel: title,
        key: Key(title),
        color: Colors.green,
        size: 40,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        DateFormat.yMMMd().add_Hm().format(dateTime),
      ),
      trailing: GestureDetector(
        onTap: () => deleteExam(title),
        child: const Icon(Icons.delete),
      ),

    );
  }
}
