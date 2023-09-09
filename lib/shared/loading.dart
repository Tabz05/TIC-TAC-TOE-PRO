import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tictactoepro/shared/colors.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
       
    return Container(
       color: backgroundColor,
       child: Center(
        child: SpinKitChasingDots(
          color: Colors.red,
          size:50.0
        )
       ),
    );
  }
}