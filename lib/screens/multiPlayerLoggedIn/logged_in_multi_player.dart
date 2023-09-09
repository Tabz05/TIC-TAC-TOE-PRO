import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/multi_player_game_model.dart';
import 'package:tictactoepro/screens/multiPlayerLoggedIn/logged_in_multi_player_fin.dart';
import 'package:tictactoepro/services/database_service.dart';

class LoggedInMultiPlayer extends StatefulWidget {
  
  final String? currUserId;
  final String? senderId;
  final String? receiverId;
  final String? senderUsername;
  final String? receiverUsername;
  final bool? senderHasProfilePic;
  final bool? receiverHasProfilePic;
  final String? senderProfilePicUri;
  final String? receiverProfilePicUri;
  final String? multiPlayerGameId;

  LoggedInMultiPlayer(this.currUserId,this.senderId,this.receiverId,this.senderUsername,this.receiverUsername,this.senderHasProfilePic,this.receiverHasProfilePic,this.senderProfilePicUri,this.receiverProfilePicUri,this.multiPlayerGameId);

  @override
  State<LoggedInMultiPlayer> createState() => _LoggedInMultiPlayerState();
}

class _LoggedInMultiPlayerState extends State<LoggedInMultiPlayer> {
  @override
  Widget build(BuildContext context) {
      
    return StreamProvider<MultiPlayerGameModel?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(multiPlayerGameID:widget.multiPlayerGameId).multiPlayerGameDetails,
      child: LoggedInMultiPlayerFin(widget.currUserId,widget.senderId,widget.receiverId,widget.senderUsername,widget.receiverUsername,widget.senderHasProfilePic,widget.receiverHasProfilePic,widget.senderProfilePicUri,widget.receiverProfilePicUri,widget.multiPlayerGameId)
    );
  }
}