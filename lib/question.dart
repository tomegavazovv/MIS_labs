import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String _questionText;

  const Question(this._questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Text(
        _questionText,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 30, color: Colors.blueAccent, fontWeight: FontWeight.bold),
      ),
    );
  }
}
