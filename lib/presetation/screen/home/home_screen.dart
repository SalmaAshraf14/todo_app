import 'package:flutter/material.dart';
import 'package:todoo_app/presetation/screen/home/tabs/settings_tab/settings_tab.dart';

import 'tabs/tasks_tab/task_tab.dart';
import 'tasks_bottom_sheet/task_dottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<TasksTabState> tasksTabKey = GlobalKey();
  int currentIndex = 0;
  List<Widget> tabs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs = [
      TasksTab(
        key: tasksTabKey,
      ),
      SettingsTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: const Text('ToDo List'),
      ),

      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: buildBottomNavBar(),
      body: tabs[currentIndex],
    );
  }

  buildBottomNavBar() => BottomAppBar(
    notchMargin: 8,
    child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ]),
  );

  void onTapped(int index) {
    currentIndex = index;
    setState(() {});
  }

  Widget buildFab() => FloatingActionButton(
        onPressed: () async {
          await TaskBottomSheet.show(context);
          tasksTabKey.currentState?.getTodosFromFireStore();
        }
    ,child: const Icon(
    Icons.add,),
  );
}

