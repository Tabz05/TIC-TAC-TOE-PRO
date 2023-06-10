import 'package:flutter/material.dart';

class UserDataModel with ChangeNotifier{

   final String? uid;
   
   final String? username;
   final String? email;

   final int? matches;
   final int? won;
   final int? lost;
   final int? draw;

   final int? first;
   final int? second;

   final int? wonFirst;
   final int? wonSecond;

   final bool? hasProfilePic;
   final String? profilePicUri;

   UserDataModel({this.uid,this.username,this.email,this.matches,this.won,this.lost, this.draw,
                  this.first,this.second,this.wonFirst,this.wonSecond,
                  this.hasProfilePic,this.profilePicUri});

}