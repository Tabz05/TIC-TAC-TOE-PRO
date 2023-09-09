import 'package:flutter/material.dart';

class InviteSenderDataModel with ChangeNotifier{

   final String? uid;
   final String? username;
   final String? email;

   int? matches;
   int? won;
   int? lost;
   int? draw;

   int? first;
   int? second;

   int? wonFirst;
   int? wonSecond;

   int? multi_matches;
   int? multi_won;
   int? multi_lost;
   int? multi_draw;

   int? multi_first;
   int? multi_second;

   int? multi_wonFirst;
   int? multi_wonSecond;

   bool? hasProfilePic;
   String? profilePicUri;

   List<String>? invites=[];

   InviteSenderDataModel({this.uid,this.username,this.email,this.matches,this.won,this.lost, this.draw,
                  this.first,this.second,this.wonFirst,this.wonSecond,this.multi_matches,this.multi_won,
                  this.multi_lost, this.multi_draw,this.multi_first,this.multi_second,this.multi_wonFirst,
                  this.multi_wonSecond,this.hasProfilePic,this.profilePicUri,this.invites});

}