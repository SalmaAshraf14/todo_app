import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoo_app/datebase_manager/model/date_dm.dart';
import 'package:todoo_app/datebase_manager/model/user_dm.dart';

class FirebaseFunctions {
  static CollectionReference getCollection() {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDm.collectionName)
        .doc(UserDm.currentUser!.id)
        .collection(TodoDM.collectionName);
    return todoCollection;
  }

  static Future<void> updateTask(TodoDM todo) async {
    CollectionReference todoCollection = getCollection();
    DocumentReference todoDoc = todoCollection.doc(todo.id);
    await todoDoc.update(todo.toFireStore());
  }

  static Future<void> updateIsDone(TodoDM todo) async {
    CollectionReference todoCollection = getCollection();
    DocumentReference todoDoc = todoCollection.doc(todo.id);
    await todoDoc.update({'isDone': !todo.isDone});
  }
}
