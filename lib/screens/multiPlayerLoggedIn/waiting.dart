import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tictactoepro/shared/colors.dart';

class Waiting extends StatefulWidget {

  final String? receiverUsername;
  Waiting(this.receiverUsername);

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
      backgroundColor: backgroundColor,
      body: Container(  
        width: double.infinity,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Flexible(child: SizedBox(),flex:1,fit:FlexFit.tight),  
          Text('Waiting for ${widget.receiverUsername!} to join...'),
          Flexible(child: SizedBox(),flex:1,fit:FlexFit.tight),
          SpinKitChasingDots(
          color: Colors.red,
          size:50.0
        ),
          Flexible(child: SizedBox(),flex:3,fit:FlexFit.tight),
        ],)
      ),
    ));
  }
}