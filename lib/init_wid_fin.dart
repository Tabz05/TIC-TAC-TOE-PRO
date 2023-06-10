import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/user_id_model.dart';
import 'package:tictactoepro/screens/home.dart';
import 'package:tictactoepro/screens/home_log_in.dart';

class InitializerWidgetFin extends StatefulWidget {
  const InitializerWidgetFin({super.key});

  @override
  State<InitializerWidgetFin> createState() => _InitializerWidgetFinState();
}

class _InitializerWidgetFinState extends State<InitializerWidgetFin> {

  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserIdModel?>(context);

    print("over hereee"+_user.toString());

    return _user==null? Home() : HomeLogIn(_user.uid!.toString());
  }
}