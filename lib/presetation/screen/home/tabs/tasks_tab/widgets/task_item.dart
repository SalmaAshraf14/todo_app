import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todoo_app/core/firebase/firebase_functions.dart';
import 'package:todoo_app/core/utils/date_utils.dart';
import 'package:todoo_app/core/utils/routes_manager.dart';
import 'package:todoo_app/datebase_manager/model/date_dm.dart';
import 'package:todoo_app/datebase_manager/model/user_dm.dart';
import 'package:todoo_app/presetation/screen/home/tabs/tasks_tab/task_tab.dart';

import '../../../../../../core/utils/colors_manager.dart';

class TaskItem extends StatelessWidget {
  TaskItem(
      {super.key,
      required this.todo,
      required this.onDeletedTask,
      required this.todoKey});
  TodoDM todo;
  Function onDeletedTask;
  final GlobalKey<TasksTabState> todoKey;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).colorScheme.onPrimary),


                  child: Slidable(
                    startActionPane: ActionPane(motion: DrawerMotion(),
                          children: [
                      SlidableAction(
                        flex: 2,
                        onPressed: (context) {
                deleteTodoFromFireStore(todo);
                onDeletedTask();
              },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                        autoClose: true,
                        //borderRadius: BorderRadius.only(
                           // bottomLeft: Radius.circular(15), topLeft: Radius.circular(15)),
                      ),
                      SlidableAction(

                        flex: 2,
                        onPressed: (context) {
                Navigator.of(context).pushNamed(
                  RoutesManager.updateScreen,
                  arguments: todo,
                );
              },
                        backgroundColor: ColorsManager.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                        autoClose: true,

                      ),
                    ]),
                    child: Container(
                      //margin:EdgeInsets.all(8),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(15),),
                      child: Row(
                        children: [
                          Container(
                            height: 62,
                            width: 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                      color: todo.isDone ? Colors.green : Colors.blue),
                ),
                          SizedBox(width: 7,),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                    Text(
                      todo.title,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color:
                              todo.isDone ? Colors.green : ColorsManager.blue),
                    ),
                    SizedBox(height: 4,),
                    Text(todo.description,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: ColorsManager.blue)),
                    SizedBox(height: 4,),
                              Text(DateTime.now().toFormattedDate,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: ColorsManager.blue)),
                            ],
                          ),
                          Spacer(),
                InkWell(
                  onTap: () {
                    FirebaseFunctions.updateIsDone(todo);
                    todoKey.currentState?.getTodosFromFireStore();
                  },
                  child: todo.isDone
                      ? const Text(
                          'isDone',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.green),
                        )
                      : Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            Icons.check,
                            color: todo.isDone ? Colors.green : Colors.white,
                            size: 30,
                          )),
                )
              ],
                      ),
                    ),
                  ));
  }

  void deleteTodoFromFireStore(TodoDM todo) async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDm.collectionName)
        .doc(UserDm.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference todoDoc = todoCollection.doc(todo.id);
    await todoDoc.delete();
  }
}

class DateToUpdateScreen {
  TodoDM todo;
  var todoKey;

  DateToUpdateScreen({required this.todo, required this.todoKey});
}
