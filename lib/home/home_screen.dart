import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/settings/settings_tab.dart';
import 'package:todo_app/home/task_list/add_task_button_sheet.dart';
import 'package:todo_app/home/task_list/task_list_tab.dart';

import '../provider/app_language_provider.dart';
import '../provider/app_mode_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_scrren';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppLanguageProvider>(context);
    var modeProvider = Provider.of<AppModeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: AppLocalizations.of(context)!.task_list),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: AppLocalizations.of(context)!.settings)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskButtomSheet();
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          // Container(
          //   color: AppColors.primaryColor,
          //   width: double.infinity,
          //   height: 80,
          // ),
          Expanded(child: selectedIndex == 0 ? TaskListTab() : SettingsTab()),
        ],
      ),
    );
  }

  void addTaskButtomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => AddTaskBottomShet());
  }
}
