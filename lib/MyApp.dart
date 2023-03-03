import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_4/Calendar.dart';

import 'AddExamForm.dart';
import 'ExamTile.dart';
import './models/Exam.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<Exam> exams = [];
  bool showCalendar = false;
  var db = FirebaseFirestore.instance;
  String currentUser = FirebaseAuth.instance.currentUser!.email.toString();

  void addExam(String title, DateTime dateTime) {
    db.collection(currentUser).add({
      "title": title,
      "date": dateTime,
    });
    setState(() {
      exams.add(Exam(title: title, date: dateTime));
    });
  }

  void deleteExam(String title) {
    db
        .collection(currentUser)
        .where("title", isEqualTo: title)
        .get()
        .then((querySnapshot) => querySnapshot.docs.forEach((documentSnapshot) {
      documentSnapshot.reference
          .delete()
          .then((value) => print("Document deleted successfully."))
          .catchError(
              (error) => print("Failed to delete document: $error"));
    }));
    setState(() {
      exams.removeWhere((exam) => exam.title == title);
    });
  }

  void _showForm() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddExamForm(addExam: addExam),
    );
  }

  @override
  void initState() {
    super.initState();
    populate();
  }

  void populate() async {
    var ex = <Exam>[];
    await db.collection(currentUser).get().then((event) {
      for (var doc in event.docs) {
        Exam exam =
        Exam(title: doc.data()['title'], date: doc.data()['date'].toDate());
        ex.add(exam);
      }
    });
    setState(() {
      exams = ex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of exams"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              setState(() {
                showCalendar = !showCalendar;
              });
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrangeAccent),
            child: const Icon(Icons.calendar_month),
          ),
          const Divider(indent: 5),
          ElevatedButton(
            onPressed: _showForm,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Icon(Icons.add),
          ),
          const Divider(indent: 5),
          ElevatedButton(
            onPressed: _showForm,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Icon(Icons.logout),
          ),
          const Divider(indent: 5),
        ],
      ),
      body: Column(
        children: [
          if (showCalendar)
            Expanded(
              child: Calendar(exams: exams),
            ),
          if (exams.isNotEmpty)
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: exams.length,
                itemBuilder: (context, index) {
                  return ExamTile(
                    title: exams[index].title,
                    dateTime: exams[index].date,
                    deleteExam: deleteExam,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
