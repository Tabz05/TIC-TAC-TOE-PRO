import 'package:flutter/material.dart';
import 'package:tictactoepro/screens/authentication/register.dart';
import 'package:tictactoepro/screens/authentication/signin.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool _showSignIn = true;

  void toggleView()
  {
    setState(() {
      _showSignIn = !_showSignIn;
    });
    
  }

  @override
  Widget build(BuildContext context) {

    return _showSignIn? SignIn(toggleView) : Register(toggleView);
  }
}