import 'package:flutter/material.dart';
import 'tabs/tasks_tab/task_tab.dart';
import 'tasks_bottom_sheet/task_dottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
   TasksTab(),
   TasksTab(),
  ];



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
    onPressed: (){
      showTaskBottomSheet();
    }
    ,child: const Icon(
    Icons.add,),
  );

  void showTaskBottomSheet(){
    showModalBottomSheet(context:context ,builder: (context) =>TaskBottomSheet(),);
  }

}

