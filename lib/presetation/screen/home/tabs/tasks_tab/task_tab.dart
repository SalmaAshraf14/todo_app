
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todoo_app/core/utils/colors_manager.dart';

import 'widgets/task_item.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  DateTime calenderSelectedDate = DateTime.now();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

            buildCalenderTimeLine(),
        TaskItem(),
          ],

    ); // rendering ui
  }

  Widget buildCalenderTimeLine() =>EasyDateTimeLine(
    initialDate: DateTime.now(),
    onDateChange: (selectedDate) {
      //`selectedDate` the new date selected.
    },
    headerProps: const EasyHeaderProps(
      showHeader: false,
      monthPickerType: MonthPickerType.switcher,
      dateFormatter: DateFormatter.fullDateDMY(),
    ),
    dayProps: const EasyDayProps(
      height: 75,
      width: 50,

      dayStructure: DayStructure.dayStrDayNum,
      activeDayStyle: DayStyle(
        dayStrStyle: TextStyle(color: ColorsManager.blue,fontSize: 15,fontWeight:FontWeight.w700),
        dayNumStyle: TextStyle(color: ColorsManager.blue,fontSize: 15,fontWeight:FontWeight.w700),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          color: Colors.white
             ),

          ),
  inactiveDayStyle: DayStyle(
  dayStrStyle: TextStyle(color: ColorsManager.black,fontSize: 15,fontWeight:FontWeight.w700),
  dayNumStyle: TextStyle(color: ColorsManager.black,fontSize: 15,fontWeight:FontWeight.w700),
  decoration: BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(8)),
  color: Colors.white
        ),
  )
  ));
}