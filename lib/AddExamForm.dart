import 'package:flutter/material.dart';

typedef AddExamTypeDef = void Function(String, DateTime);

class AddExamForm extends StatefulWidget {
  final AddExamTypeDef addExam;

  const AddExamForm({Key? key, required this.addExam}) : super(key: key);

  @override
  State<AddExamForm> createState() => _AddExamFormState();
}

class _AddExamFormState extends State<AddExamForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  late DateTime _date = DateTime.now();
  late TimeOfDay _time = TimeOfDay.fromDateTime(_date);
  final String dateErrorMsg =
      'Please enter the date of the exam in the following format mm/dd/yyyy';

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Title'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter the name of the subject";
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: const Icon(Icons.calendar_today),
              ),
              TextButton(
                onPressed: () {
                  final now = DateTime.now();
                  showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: now,
                    lastDate: now.add(const Duration(days: 365)),
                  ).then((pickedDate) {
                    if (pickedDate == null) return;
                    setState(() {
                      _date = pickedDate;
                    });
                  });
                },
                child: Text(
                  '${_date.day}/${_date.month}/${_date.year}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: GestureDetector(
              onTap: () => showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              ).then(
                    (value) => _time = value!,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.access_time),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Click to select the time'),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  var dateWithTime = DateTime(
                    _date.year,
                    _date.month,
                    _date.day,
                    _time.hour,
                    _time.minute,
                  );
                  widget.addExam(_nameController.text, dateWithTime);
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
