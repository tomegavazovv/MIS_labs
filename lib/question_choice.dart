import 'package:flutter/material.dart';

class QuestionChoice extends StatelessWidget {
  final String _choiceText;
  final VoidCallback _callBack;

  const QuestionChoice(this._callBack, this._choiceText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(5),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.red,
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: _callBack,
        child: Text(_choiceText),
      ),
    );
  }
}
