import 'package:flutter/material.dart';
import 'package:todoo_app/core/utils/date_utils.dart';


import '../../../../core/utils/app_styles.dart';

class TaskBottomSheet extends StatefulWidget {
  TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Add new Task'),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your task title',
              hintStyle: AppLightStyles.hintStyle,
            ),

          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter your task description',
              hintStyle: AppLightStyles.hintStyle,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'Select date',
            style: AppLightStyles.dateLabel,
          ),
          SizedBox(
            height: 8,
          ),
          InkWell(
              onTap: () {
                showTaskDatePicker();
              },
              child: Text(
                selectedDate.toFormattedDate,
                textAlign: TextAlign.center,
                style: AppLightStyles.dateStyle,
              )),
          Spacer(),
          ElevatedButton(
              onPressed: () {},
              child: Text('Add task'))
        ],


      ),
    );
  }

  static Widget show() => TaskBottomSheet();


  void showTaskDatePicker() async {
    selectedDate = await showDatePicker(
      //selectableDayPredicate: (date) => date. != 20 && date.day != 21,
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ) ?? selectedDate;

    setState(() {});
  }

}
