import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoepro/firebase_options.dart';
import 'package:tictactoepro/init_wid.dart';
import 'package:tictactoepro/screens/agree.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  Future _userAccepted() async {
    
    SharedPreferences sp = await SharedPreferences.getInstance();

    String accept = sp.getString('accept') ?? 'not';

    return accept;
  }

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _userAccepted(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return SizedBox();
          } else if (snapshot.hasData) {
            if (snapshot.data == 'not') {

              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Agreement(),
              );
            } else {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home:InitializerWidget(),
              );

            }
          } else {
            return SizedBox();
          }
        } else {
          return SizedBox();
        }
      },
    );
  }
}
