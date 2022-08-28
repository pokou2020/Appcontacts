import 'package:appcontact/screen/recherche.dart';
import 'package:appcontact/screen/update.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'editContact.dart';
import '../model/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  void deco() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes contacts"),
        actions: [
          IconButton(onPressed: () {
         showSearch(context: context, delegate: MypageSeach());
          }, icon: const Icon(Icons.search)),
          IconButton(onPressed: deco, icon: const Icon(Icons.dangerous))
          ],
      ),
      body: StreamBuilder<List<Users>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Erreur ! ${snapshot.error}  ');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;

              return ListView(
                children: users.map(builUser).toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(EditContact.routeName);
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget builUser(Users user) => ListTile(
      title: Text(user.nom.toString()),
      subtitle: Text(user.contact.toString()),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.image.toString()),
      ),
      trailing: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return UpdateContact(
                user: user,
              );
            }));
          },
          icon: const Icon(Icons.edit_outlined)),);
  Stream<List<Users>> readUsers() => FirebaseFirestore.instance
      .collection("users")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());

  // Future updateUser( User user) async {
  //   final docUser = FirebaseFirestore.instance.collection("users").doc( );
  //   user.id = docUser.id;

  //   final json = user.toJson();
  //   await docUser.set(json);
  // }

  
}
