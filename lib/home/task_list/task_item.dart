import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/provider/list_provider.dart';

import '../../model/task.dart';
import '../../provider/app_language_provider.dart';
import '../../provider/app_mode_provider.dart';

class TaskListItem extends StatelessWidget {
  Task task;

  TaskListItem({required this.task});
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var langProvider = Provider.of<AppLanguageProvider>(context);
    var modeProvider = Provider.of<AppModeProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.40,
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),
          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              onPressed: (context) {
                ///delete task
                FirebaseUtils.deleteTaskFromFireStore(task)
                    .timeout(Duration(seconds: 1), onTimeout: () {
                  print('task deleted successfully');
                });
                listProvider.getTasksFromFireStore();
              },
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(20),
              onPressed: (context) {
                ///edit task
              },
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: modeProvider.isDarkMode()
                ? AppColors.blackColor
                : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(12),
                color: AppColors.primaryColor,
                height: MediaQuery.of(context).size.height * 0.1,
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(task.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge?.copyWith(
                            color: modeProvider.isDarkMode()
                                ? AppColors.primaryColor
                                : AppColors.primaryColor,
                          )),
                  Text(task.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge?.copyWith(
                            color: modeProvider.isDarkMode()
                                ? AppColors.whiteColor
                                : AppColors.blackColor,
                          )),
                ],
              )),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: AppColors.primaryColor),
                child: Icon(
                  Icons.check,
                  color: AppColors.whiteColor,
                  size: 40,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
