import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/model.dart';

class EditContact extends StatefulWidget {
  static const routeName = 'edit_contacts';

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final controllerName = TextEditingController();
  // final controllerPrenom = TextEditingController();
  final controllerContact = TextEditingController();
  final controllerImage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouveau contacts'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (controllerName.text.isNotEmpty &&
                  controllerImage.text.isNotEmpty) {
                final user = Users(
                  nom: controllerName.text,
                  // prenom: controllerPrenom.text,
                  contact: controllerContact.text,
                  image: controllerImage.text,
                );
                Navigator.of(context).pop();
                createUser(user);
             
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("champs vide "),
                ));
                 
              }
                
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: controllerName,
              // initialValue: _initValues['nom'],
              decoration: InputDecoration(labelText: 'Nom'),
            ),
            // TextField(
            //   controller: controllerPrenom,
            //   // initialValue: _initValues['prenom'],
            //   decoration: InputDecoration(labelText: 'Prenom'),
            //   keyboardType: TextInputType.multiline,

            // ),
            TextField(
              controller: controllerContact,
              decoration: InputDecoration(labelText: 'Numero'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
            ),

            TextField(
              controller: controllerImage,
              // initialValue: _initValues['nom'],
              decoration: InputDecoration(labelText: 'url image'),
            ),
          ],
        ),
      ),
    );
  }

  Future createUser(Users user) async {
    final docUser = FirebaseFirestore.instance.collection("users").doc();
    user.id = docUser.id;

    final json = user.toJson();
    await docUser.set(json);
  }
}
