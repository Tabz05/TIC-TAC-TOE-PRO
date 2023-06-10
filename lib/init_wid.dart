import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/init_wid_fin.dart';
import 'package:tictactoepro/models/user_id_model.dart';
import 'package:tictactoepro/services/auth_service.dart';

class InitializerWidget extends StatefulWidget {

  const InitializerWidget({super.key});

  @override
  State<InitializerWidget> createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<UserIdModel?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: AuthService().userId,
      child: InitializerWidgetFin(),
    );

  }
}