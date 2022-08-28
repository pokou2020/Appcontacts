import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/model.dart';

// class UpdateContact extends StatefulWidget {
//   final User user;
//   const UpdateContact({Key? key, required this.user}) : super(key: key);

//   @override
//   _UpdateContactState createState() => _UpdateContactState();
// }

// // User? user;

// class _UpdateContactState extends State<UpdateContact> {
//   final controllerName = TextEditingController();
//   // final controllerPrenom = TextEditingController();
//   final controllerContact = TextEditingController();

//   // @override
//   // void initState() {
//   //   user = widget.user;
//   //   // TODO: implement initState
//   //   super.initState();
    
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Modifier'),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: () {
//               final docUser = FirebaseFirestore.instance
//                   .collection("users")
//                   .doc(widget.user.id);
//               docUser.update({
//                 'nom': controllerName.text,
//                 // prenom: controllerPrenom.text,
//                 'contact': int.parse(controllerContact.text),
//               });
             

//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: <Widget>[
//             TextField(
//               controller: controllerName,
//               // initialValue: _initValues['nom'],
//               decoration: InputDecoration(labelText : 'nom'),
//             ),
//             // TextField(
//             //   controller: controllerPrenom,
//             //   // initialValue: _initValues['prenom'],
//             //   decoration: InputDecoration(labelText: 'Prenom'),
//             //   keyboardType: TextInputType.multiline,

//             // ),
//             TextField(
//               controller: controllerContact,
//               decoration: InputDecoration(labelText: 'contact '),
//               textInputAction: TextInputAction.next,
//               keyboardType: TextInputType.number,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:appcontact/model.dart';
// import 'package:flutter/material.dart';

class UpdateContact extends StatefulWidget {
  final Users user;
  const UpdateContact({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  Users? user;
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController numberCtrl = TextEditingController();
  TextEditingController imageCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    user = widget.user;
    super.initState();
    nameCtrl = TextEditingController(text: widget.user.nom);
    numberCtrl = TextEditingController(text: widget.user.contact);
     imageCtrl = TextEditingController(text: widget.user.image);
    print("////user:${widget.user.nom}////");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: Text('Modifier'),
        actions: [
          IconButton(onPressed: (){
           if (_formKey.currentState!.validate()) {
                final docUser = FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.user.id);
                docUser.update({
                  'nom': nameCtrl.text,
                   "contact": numberCtrl.text,
                    'image':imageCtrl.text,
                });
              }
               Navigator.of(context).pop();
          }, icon: Icon(Icons.save))
           
        ],
        ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: nameCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(hintText: "nom"),
            ),
            TextFormField(
              controller: numberCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(hintText: "nom"),
            ),
                TextFormField(
              controller: imageCtrl,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter image url';
                }
                return null;
              },
              decoration: InputDecoration(hintText: "url image"),
            ),
          
          ],
        ),
      ),
    );
  }
}
