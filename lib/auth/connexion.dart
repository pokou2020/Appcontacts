import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Connexion extends StatefulWidget {
  final VoidCallback showRegisterPage;
  static const routeName = "Connexion";
  const Connexion({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
   bool _showPassword = false;
   bool isloading=false;

  

  Future signInAnon() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email:_emailController.text.trim(), 
      password:_passwordController.text.trim());
   
   
  }

  @override
  void dispose() {
    // TODO: implement initState
      _emailController.dispose();
    _passwordController.dispose(); 
    super.dispose();
  
  }

  // void signOut() async {
  //   await auth.signOut();
  //   setState(() {
  //     status = 'Deconnection';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Container(
                child: Text("Connectez-vous",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextField(
                    controller: _emailController,
                      decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Entrez du text",
                          border: OutlineInputBorder()))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 1.5,
                child: TextField(
                  
                   obscureText: !_showPassword,
                  controller:_passwordController,
                  decoration: InputDecoration(
                     suffixIcon: IconButton(
                                      icon: _showPassword
                                          ? Icon(Icons.visibility_outlined,
                                              color: Colors.grey[300])
                                          : Icon(Icons.visibility_off),
                                      onPressed: () {
                                        setState(() {
                                          _showPassword = !_showPassword;
                                        });
                                      },
                                    ),
                      labelText: "Mot de passe",
                      hintText: "Password",
                      border: OutlineInputBorder()),
                ),
              ),
            ),
               InkWell(
              onTap: () {
                if (_emailController.text.isNotEmpty &&
                    _passwordController.text.isNotEmpty) {
                  signInAnon();
                     setState(() {
                        
                        isloading=true;
                        
                      });
                } else  {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("champs vide ou password incorrect"),
                  )
                  );
                }
              },
              child:!isloading ? Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.greenAccent,
                ),
                child: Center(
                  child: Text("Se connecter",
                      style: TextStyle(color: Colors.white)),
                ),
              ):Center(child: CircularProgressIndicator()),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text('Vous avez pas de compte?'),
                  ),
                  SizedBox(width: 2,),
                   GestureDetector(
                    onTap:widget.showRegisterPage,
                    child: Text("S'inscrire",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
