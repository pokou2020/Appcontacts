import 'package:cloud_firestore/cloud_firestore.dart';

class DataController extends Getxcontroller {
  Future getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  Future queryData(String queryString) async {
    return FirebaseFirestore.instance.collection("users").where('nom',isGreaterThanOrEqualTo: queryString).get();
  }
}

class Getxcontroller {}
