import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class DetailContact extends StatefulWidget {
  DetailContact({Key? key, required this.data}) : super(key: key);

  final QueryDocumentSnapshot<Object?>?data;

  @override
  State<DetailContact> createState() => _DetailContactState();
}

class _DetailContactState extends State<DetailContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info contact'),
      ),

      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height:150,
              width: 150,  
              decoration: BoxDecoration(
                 color: Colors.blue,
                 shape: BoxShape.circle,
                 image: DecorationImage(image:NetworkImage( widget.data!.get('image'),), fit: BoxFit.cover)
                 
              ),
              
            ),
              SizedBox(
              height: 20,
            ),
            Container(
              child: Text(widget.data!.get('nom'), 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ))
            ),
             SizedBox(
              height: 10,
            ),
             Container(
              child: Text(widget.data!.get('contact'))
            ),

            SizedBox(
              height: 100,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              
              Container(
                height: 40,
                width: 40,
                child: IconButton(
        
              onPressed: () {
             final docUser =
              FirebaseFirestore.instance.collection('users').doc(widget.data!.id);
               docUser.delete();
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Element supprimer"),
                  )
                  );
             },
             icon: const Icon(Icons.delete, color:Colors.white),
              ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),

                ),
              ),
                 Container(
                height: 70,
                width: 70,
                child: Icon(Icons.message, color: Colors.white,),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),

                ),
              ),
                 Container(
                height: 40,
                width: 40,
                child: Icon(Icons.call, color: Colors.white,),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),

                ),
              ),
              ],
            )
          ],
        ),
      )
    );
  }
}