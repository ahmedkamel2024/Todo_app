import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_colors.dart';
import 'package:todo_app/home/task_list/task_item.dart';
import 'package:todo_app/provider/list_provider.dart';

import '../../provider/app_language_provider.dart';
import '../../provider/app_mode_provider.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    var langProvider = Provider.of<AppLanguageProvider>(context);
    var modeProvider = Provider.of<AppModeProvider>(context);
    if (listProvider.tasksList.isEmpty) {
      listProvider.getTasksFromFireStore();
    }
    return Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            listProvider.changeSelectDate(selectedDate);
          },
          headerProps: const EasyHeaderProps(
            monthPickerType: MonthPickerType.dropDown,
            dateFormatter: DateFormatter.fullDateDMonthAsStrY(),
            selectedDateStyle: TextStyle(color: AppColors.primaryColor),
          ),
          dayProps: EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff3371FF),
                    Color(0xff8426D6),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskListItem(
                task: listProvider.tasksList[index],
              );
            },
            itemCount: listProvider.tasksList.length,
          ),
        )
      ],
    );
  }
}
