
import 'package:flutter/material.dart';

import 'connexion.dart';
import 'inscription.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showConnexionPage = true;

  void toogleScreem() {
    setState(() {
      showConnexionPage = !showConnexionPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showConnexionPage) {
      return Connexion(showRegisterPage: toogleScreem);
    } else {
      return Inscription(
        showConnexionPage: toogleScreem,
      );
    }
  }
}
