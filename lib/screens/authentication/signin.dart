import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/user_id_model.dart';
import 'package:tictactoepro/screens/home_log_in.dart';
import 'package:tictactoepro/services/auth_service.dart';
import 'package:tictactoepro/shared/colors.dart';

class SignIn extends StatefulWidget {
  final Function _toggleView;
  SignIn(this._toggleView);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  String _error = "";

  bool _showPass=false;

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
            Text('Sign In to your account',
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
                      obscureText: !_showPass,
                      decoration: InputDecoration(
                          hintText: "Password",
                          icon: Icon(Icons.lock),
                          border: InputBorder.none,
                          suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPass = !_showPass;
                            });
                          },
                          child: Icon(
                            _showPass ? Icons.visibility_off : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),),
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

                        _email = _email.trim();
                        
                        dynamic result = await _auth.signInEmailAndPassword(
                            _email, _password);

                        print("result"+result.toString());

                        if (result == null) {
                          setState(() {
                            _error =
                                "Could not sign in. Invalid credentials or no internet connection";
                          });
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => HomeLogIn(result.uid!.toString()),
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
                    "Don't have an account?",
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
                        'Register',
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
