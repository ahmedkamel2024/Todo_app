import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
          fromFirestore: (snapshot, options) =>
              Task.fromFireStore(snapshot.data()!),
          toFirestore: (task, _) => task.toFireStore(),
        );
  }

  static Future<void> AddTaskToFireStore(Task task) {
    var taskCollection = getTasksCollection();

    /// collection
    DocumentReference<Task> taskRef = taskCollection.doc();

    /// document
    task.id = taskRef.id;

    /// auto Id
    return taskRef.set(task);
  }
}
