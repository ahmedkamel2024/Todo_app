import 'package:flutter/material.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';

class AddTaskBottomShet extends StatefulWidget {
  @override
  State<AddTaskBottomShet> createState() => _AddTaskBottomShetState();
}

class _AddTaskBottomShetState extends State<AddTaskBottomShet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Add New Task',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter task title';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      title = text;
                    },
                    decoration: InputDecoration(hintText: 'Enter Task Title'),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'please enter task description';
                      }
                      return null;
                    },
                    onChanged: (text) {
                      description = text;
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter Task Describtion',
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Select Date',
                          style: Theme.of(context).textTheme.bodyLarge)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showCalendar();
                      },
                      child: Text(
                          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        addTask();
                      },
                      child: Text(
                        'Add',
                        style: Theme.of(context).textTheme.titleLarge,
                      )),
                ],
              ))
        ],
      ),
    );
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Task task =
          Task(title: title, description: description, dateTime: selectedDate);
      FirebaseUtils.AddTaskToFireStore(task).timeout(Duration(seconds: 1),
          onTimeout: () {
        print('task added successfully');
        Navigator.pop(context);
      });
    }
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (chosenDate != null) {
      selectedDate = chosenDate;
    }
    setState(() {});
  }
}
