import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos_bloc/model/todo_model.dart';

class TodoService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createTodo(String title) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;

      DocumentReference todoRef =
          _firestore.collection('users').doc(uid).collection('todos').doc();
      try {
        await todoRef.set({
          'id': todoRef.id,
          'title': title,
          'isCompleted': false,
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Future<List<TodoModel>> getTodos() async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;

      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection('todos')
          .get();

      return querySnapshot.docs.map((doc) {
        return TodoModel.fromDocument(doc.data() as Map<String, dynamic>);
      }).toList();
    }
    return [];
  }

  Future<void> updateTodo(TodoModel todo) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;

      await _firestore
          .collection('users')
          .doc(uid)
          .collection('todos')
          .doc(todo.id)
          .update(todo.toDocument());
    }
  }

  Future<void> deleteTodo(String id) async {
    User? user = _auth.currentUser;
    if (user != null) {
      String uid = user.uid;

      await _firestore
          .collection('users')
          .doc(uid)
          .collection('todos')
          .doc(id)
          .delete();
    }
  }
}
