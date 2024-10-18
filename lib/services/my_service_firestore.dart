import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firetask/models/task_model.dart';
import 'package:firetask/models/user_model.dart';

class MyServiceFirestore {
  final String collection;

  MyServiceFirestore({required this.collection});

  late final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection(collection);

  /// Adds a new task to the Firestore collection associated with the user.
  Future<String> addTask(TaskModel model, String userId) async {
    try {
      DocumentReference documentReference = await _collectionReference.add({
        ...model.toJson(),
        'userId': userId,
      });
      return documentReference.id;
    } catch (e) {
      // Manejar el error según sea necesario
      throw Exception('Error al agregar la tarea: $e');
    }
  }

  /// Marks a task as finished by updating its status.
  Future<void> finishedTask(String taskId) async {
    try {
      await _collectionReference.doc(taskId).update({
        "status": false,
      });
    } catch (e) {
      // Manejar el error según sea necesario
      throw Exception('Error al actualizar el estado de la tarea: $e');
    }
  }

  /// Adds a new user to the Firestore collection.
  Future<String> addUser(UserModel userModel) async {
    try {
      DocumentReference documentReference =
          await _collectionReference.add(userModel.toJson());
      return documentReference.id;
    } catch (e) {
      // Manejar el error según sea necesario
      throw Exception('Error al agregar el usuario: $e');
    }
  }

  /// Checks if a user with the given email already exists in the collection.
  Future<bool> existUser(String email) async {
    try {
      QuerySnapshot collection =
          await _collectionReference.where("email", isEqualTo: email).get();
      return collection.docs.isNotEmpty;
    } catch (e) {
      // Manejar el error según sea necesario
      throw Exception('Error al verificar la existencia del usuario: $e');
    }
  }
}
