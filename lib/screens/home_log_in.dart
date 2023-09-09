import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/user_data_model.dart';
import 'package:tictactoepro/screens/home_log_in_main.dart';
import 'package:tictactoepro/services/database_service.dart';

class HomeLogIn extends StatefulWidget {
  
  String? _userId;
  HomeLogIn(this._userId);

  @override
  State<HomeLogIn> createState() => _HomeLogInState();
}

class _HomeLogInState extends State<HomeLogIn> {
  @override
  Widget build(BuildContext context) {

    print('home log in....');
      
    return StreamProvider<UserDataModel?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(uid: widget._userId!.toString()).userDetails,
      child: HomeLogInMain()
    );

  }
}