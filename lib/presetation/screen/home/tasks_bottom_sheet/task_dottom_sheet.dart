import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoo_app/core/utils/date_utils.dart';
import 'package:todoo_app/datebase_manager/model/date_dm.dart';

import '../../../../core/utils/app_styles.dart';

class TaskBottomSheet extends StatefulWidget {
  TaskBottomSheet({super.key});

  @override
  State<TaskBottomSheet> createState() => _TaskBottomSheetState();

  static void show(BuildContext context) => {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: TaskBottomSheet(),
              );
            }),
      };
}

class _TaskBottomSheetState extends State<TaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 325.h,
      padding: REdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add new Task',
            textAlign: TextAlign.center,
            style: AppLightStyles.bottomSheetTitle,
          ),
          SizedBox(height: 8.h),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Enter your task title',
              hintStyle: AppLightStyles.hintStyle,
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: 'Enter your task description',
              hintStyle: AppLightStyles.hintStyle,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Select date',
            style: AppLightStyles.dateLabel,
          ),
          SizedBox(
            height: 8.h,
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
              onPressed: () {
                addTaskToFireStore();
              },
              child: Text('Add task'))
        ],
      ),
    );
  }

  void showTaskDatePicker() async {
    selectedDate = await showDatePicker(
          //selectableDayPredicate: (date) => date. != 20 && date.day != 21,
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        ) ??
        selectedDate;

    setState(() {});
  }

  addTaskToFireStore() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);
    DocumentReference documentReference = collectionReference.doc();
    TodoDM todo = TodoDM(
      id: documentReference.id,
      title: titleController.text,
      description: descriptionController.text,
      dateTime: selectedDate,
      isDone: false,
    );
    documentReference
        .set(todo.toFireStore())
        .then(
          (_) {},
        )
        .onError(
          (error, stackTrace) {},
        )
        .timeout(
      const Duration(milliseconds: 500),
      onTimeout: () {
        print('enter timeout');
        if (context.mounted) {
          Navigator.pop(context);
        }
      },
    );
  }
}
