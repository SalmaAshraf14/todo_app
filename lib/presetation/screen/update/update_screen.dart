import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoo_app/core/firebase/firebase_functions.dart';
import 'package:todoo_app/core/utils/app_styles.dart';
import 'package:todoo_app/core/utils/colors_manager.dart';
import 'package:todoo_app/core/utils/date_utils.dart';
import 'package:todoo_app/datebase_manager/model/date_dm.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as TodoDM;

    var formatDate = data.dateTime.toFormattedDate;
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: Stack(
        children: [
          Container(
            color: ColorsManager.blue,
            height: 90.h,
          ),
          Container(
            margin: REdgeInsets.only(
                right: 20.w, top: 30.h, bottom: 100.w, left: 20.h),
            padding: REdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
            width: double.infinity,
            decoration: BoxDecoration(
                color: ColorsManager.white,
                borderRadius: BorderRadius.circular(15.r)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Edit Task',
                    textAlign: TextAlign.center,
                    style: AppLightStyles.edite,
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    'This is title',
                    textAlign: TextAlign.start,
                    style: AppLightStyles.edite,
                  ),
                  TextFormField(
                    initialValue: data.title,
                    onChanged: (value) {
                      data.title = value;
                    },
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  Text(
                    'Task details',
                    textAlign: TextAlign.start,
                    style: AppLightStyles.edite,
                  ),
                  TextFormField(
                    initialValue: data.description,
                    onChanged: (value) {
                      data.description = value;
                    },
                  ),
                  Text(
                    'Selected Date',
                    textAlign: TextAlign.start,
                    style: AppLightStyles.edite,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  InkWell(
                      onTap: () async {
                        var chooseDate = await showDatePicker(
                            context: context,
                            firstDate: data.dateTime,
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ));
                        if (chooseDate != null) {
                          data.dateTime = chooseDate;
                        }
                      },
                      child: Text(
                        formatDate,
                        textAlign: TextAlign.center,
                        style: AppLightStyles.dateLabel,
                      )),
                  SizedBox(
                    height: 115.h,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r))),
                    onPressed: () async {
                      await FirebaseFunctions.updateTask(data);
                    },
                    child: Text('Save Changes'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
