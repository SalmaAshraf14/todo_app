import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:todoo_app/core/utils/date_utils.dart';

import '../../../../../../core/utils/colors_manager.dart';

class TaskItem extends StatelessWidget {
  TaskItem({super.key, });
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
                          print('Click');
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
                          print('Clicked');
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
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(width: 7,),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              Text('Task dascription',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: ColorsManager.blue),),
                              SizedBox(height: 4,),
                              Text('Task title',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: ColorsManager.blue)),
                              SizedBox(height: 4,),
                              Text(DateTime.now().toFormattedDate,style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: ColorsManager.blue)),
                            ],
                          ),
                          Spacer(),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10),),
                              child: Icon(Icons.check,
                                color: Colors.white,size: 30,))

                        ],
                      ),
                    ),
                  ));
  }
}

