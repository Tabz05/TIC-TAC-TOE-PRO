import 'package:flutter/material.dart';
import 'package:tictactoepro/screens/home_log_in.dart';
import 'package:tictactoepro/services/auth_service.dart';
import 'package:tictactoepro/shared/colors.dart';

class Register extends StatefulWidget {
  final Function _toggleView;
  Register(this._toggleView);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _username = "";
  String _email = "";
  String _password = "";
  String _error = "";

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text('Create a new account',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Username",
                          icon: Icon(Icons.person),
                          border: InputBorder.none),
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "Please enter username";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String val) {
                        _username = val;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Email",
                          icon: Icon(Icons.email),
                          border: InputBorder.none),
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "Please enter email";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String val) {
                        _email = val;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black)),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          icon: Icon(Icons.lock),
                          border: InputBorder.none),
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "Please enter password";
                        } else if (value != null && value.length < 6) {
                          return "Password must be at least 6 characters";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String val) {
                        _password = val;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result =
                            await _auth.registerWithEmailAndPassword(
                                _email, _password, _username);

                        if (result == null) {
                          setState(() {
                            _error =
                                "Could not sign up. Credentials in use or no internet connection";
                            //loading = false;
                          });
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  HomeLogIn(result.uid!.toString()),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red),
                        child: Text('Submit',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                      onTap: () {
                        widget._toggleView();
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    _error,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    ));
  }
}
