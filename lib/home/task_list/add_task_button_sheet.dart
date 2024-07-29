import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/provider/list_provider.dart';

import '../../provider/app_language_provider.dart';
import '../../provider/app_mode_provider.dart';

class AddTaskBottomShet extends StatefulWidget {
  @override
  State<AddTaskBottomShet> createState() => _AddTaskBottomShetState();
}

class _AddTaskBottomShetState extends State<AddTaskBottomShet> {
  var formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  String title = '';
  String description = '';
  late ListProvider listProvider;
  late AppLanguageProvider langProvider;
  late AppModeProvider modeProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    var langProvider = Provider.of<AppLanguageProvider>(context);
    var modeProvider = Provider.of<AppModeProvider>(context);
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.add_new_task,
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
                      decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.title)),
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
                      hintText: AppLocalizations.of(context)!.description,
                    ),
                    maxLines: 4,
                  ),
                  SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(AppLocalizations.of(context)!.select_time,
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
                        AppLocalizations.of(context)!.add,
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
        listProvider.getTasksFromFireStore();
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
