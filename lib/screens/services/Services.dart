import 'package:cloud_firestore/cloud_firestore.dart';

class Services {
  Future<QuerySnapshot> fetchData() async {
    return FirebaseFirestore.instance.collection('ToDo').get();
  }

  Future<void> addData(description) async {
    FirebaseFirestore.instance
        .collection('ToDo')
        .add({'description': description});
  }

  Future<void> deleteData(id) async {
    FirebaseFirestore.instance.collection('ToDo').doc(id).delete();
  }

  Future<void> updateData(description, id) async {
    FirebaseFirestore.instance
        .collection('ToDo')
        .doc(id)
        .update({'description': description});
  }
}
