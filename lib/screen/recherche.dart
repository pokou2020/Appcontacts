import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';
import 'controllerRecherche.dart';
import 'detailContact.dart';

class MypageSeach extends SearchDelegate {
  CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('users');
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: Icon(Icons.clear),
        )
      ];

  @override
  buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.snapshots().asBroadcastStream(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (!snapshots.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print(snapshots.data);
            if (snapshots.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['nom']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text('Aucun resutat'),
              );
            } else {
              return ListView(
                children: [
                  ...snapshots.data!.docs
                      .where((QueryDocumentSnapshot<Object?> element) =>
                          element['nom']
                              .toString()
                              .toLowerCase()
                              .contains(query.toLowerCase()))
                      .map((QueryDocumentSnapshot<Object?> data) {
                    final String nom = data.get('nom');
                    final String contact = data.get('contact');
                      final String image = data['image'];

                    return ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DetailContact(data: data);
                        }));
                      },
                      title: Text(nom),
                      subtitle: Text(contact),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(image),
                      ),
                    );
                  })
                ],
              );
            }
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Recherche ici"),
    );
    // List<Users> suggestions = [];

    // return ListView.builder(
    //   itemCount: suggestions.length,
    //   itemBuilder: (context, index) {
    //     final suggestion = suggestions[index];

    //     return ListTile(
    //         title: Text(suggestion.nom.toString()),
    //         subtitle: Text('${suggestion.contact} '),
    //         onTap: () {
    //           query = suggestion.toString();
    //           showResults(context);
    //         });
    //   },
    // );
  }
}
