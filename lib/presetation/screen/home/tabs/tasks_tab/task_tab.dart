import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoo_app/core/utils/app_styles.dart';
import 'package:todoo_app/core/utils/colors_manager.dart';
import 'package:todoo_app/core/utils/date_utils.dart';
import 'package:todoo_app/datebase_manager/model/date_dm.dart';
import 'package:todoo_app/presetation/screen/home/tabs/tasks_tab/widgets/task_item.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now();
  List<TodoDM> todoList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getTodosFromFireStore();
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 115.h,
              color: ColorsManager.blue,
            ),
            buildCalenderTimeLine(),
          ],
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => TaskItem(todo: todoList[index]),
          itemCount: todoList.length,
        ))
      ],
    );
    // rendering ui
  }

  Widget buildCalenderTimeLine() => EasyInfiniteDateTimeLine(
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        focusDate: calenderSelectedDate,
        lastDate: DateTime.now().add(Duration(days: 365)),
        onDateChange: (selectedDate) {},
        itemBuilder: (context, date, isSelected, onTap) {
          return InkWell(
            onTap: () {
              calenderSelectedDate = date;
              setState(() {});
            },
            child: Card(
              color: ColorsManager.white,
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
             ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${date.day}',
                    style: isSelected
                        ? AppLightStyles.calenderSelectedItem
                        : AppLightStyles.calenderUnSelectedItem,
                  ),
                  Text(
                    date.getDayName,
                    style: isSelected
                        ? AppLightStyles.calenderSelectedItem
                        : AppLightStyles.calenderUnSelectedItem,
                  ),
                ],
              ),
            ),
          );
        },
      );

  getTodosFromFireStore() async {
    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);
    QuerySnapshot collectionSnapShot = await todoCollection.get();
    List<QueryDocumentSnapshot> documentSnapShot = collectionSnapShot.docs;
    List<TodoDM> todoList = documentSnapShot.map((docSnapShot) {
      Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
      TodoDM todo = TodoDM.formFireStore(json);
      return todo;
    }).toList();
  }
}