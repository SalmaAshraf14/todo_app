import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoo_app/core/utils/app_styles.dart';
import 'package:todoo_app/core/utils/colors_manager.dart';
import 'package:todoo_app/core/utils/date_utils.dart';
import 'package:todoo_app/datebase_manager/model/date_dm.dart';
import 'package:todoo_app/datebase_manager/model/user_dm.dart';
import 'package:todoo_app/presetation/screen/home/tabs/tasks_tab/widgets/task_item.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now();
  List<TodoDM> todosList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodosFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              color: ColorsManager.blue,
              height: 115.h,
            ),
            buildCalenderTimeLine(),
          ],
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) => TaskItem(
            todoKey: GlobalKey(),
            todo: todosList[index],
            onDeletedTask: () {
              getTodosFromFireStore();
            },
          ),
          itemCount: todosList.length,
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
              getTodosFromFireStore();
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
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDm.collectionName)
        .doc(UserDm.currentUser!.id)
        .collection(TodoDM.collectionName);
    QuerySnapshot collectionSnapShot = await todoCollection.get();

    List<QueryDocumentSnapshot> documentSnapShot = collectionSnapShot.docs;
    todosList = documentSnapShot.map((docSnapShot) {
      Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;

      TodoDM todo = TodoDM.formFireStore(json);
      return todo;
    }).toList();

    todosList = todosList
        .where(
          (todo) =>
              todo.dateTime.day == calenderSelectedDate.day &&
              todo.dateTime.month == calenderSelectedDate.month &&
              todo.dateTime.year == calenderSelectedDate.year,
        )
        .toList();
    setState(() {});
  }
}
