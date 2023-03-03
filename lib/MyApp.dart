import 'package:flutter/material.dart';

import 'AddExamForm.dart';
import 'ExamTile.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var exams;

  @override
  void initState() {
    super.initState();
    exams = {
      {
        "title": "MIS",
        "date": DateTime(2023, 1, 15, 15, 30),
      },
      {
        "title": "VNP",
        "date": DateTime(2023, 1, 20, 19, 00),
      },
    };
  }

  void addExam(String title, DateTime dateTime) {
    setState(() {
      exams.add({
        "title": title,
        "date": dateTime,
      });
    });
  }

  void deleteExam(String title) {
    setState(() {
      exams.removeWhere((exam) => exam['title'] == title);
    });
  }

  void _showForm() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddExamForm(addExam: addExam),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of exams"),
        actions: [
          ElevatedButton(
            onPressed: _showForm,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 10),
        children: [
          ...exams.map(
            (e) => ExamTile(
              title: e['title'].toString(),
              dateTime: e['date'] as DateTime,
              deleteExam: deleteExam,
            ),
          ),
        ],
      ),
    );
  }
}
