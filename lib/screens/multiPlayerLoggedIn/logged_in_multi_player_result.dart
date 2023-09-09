import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/init_wid.dart';
import 'package:tictactoepro/models/multi_player_game_model.dart';
import 'package:tictactoepro/screens/multiPlayerLoggedIn/logged_in_multi_player.dart';
import 'package:tictactoepro/services/database_service.dart';
import 'package:tictactoepro/shared/colors.dart';
import 'package:tictactoepro/shared/loading.dart';

class LoggedInMultiPlayerResult extends StatefulWidget {
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
  final String score;

  LoggedInMultiPlayerResult(
      this.currUserId,
      this.senderId,
      this.receiverId,
      this.senderUsername,
      this.receiverUsername,
      this.senderHasProfilePic,
      this.receiverHasProfilePic,
      this.senderProfilePicUri,
      this.receiverProfilePicUri,
      this.multiPlayerGameId,
      this.score);

  @override
  State<LoggedInMultiPlayerResult> createState() =>
      _LoggedInMultiPlayerResultState();
}

class _LoggedInMultiPlayerResultState extends State<LoggedInMultiPlayerResult> {
  final DatabaseService _databaseService = DatabaseService();

  Future _updateStats() async {
    if (widget.currUserId == widget.senderId) {
      await _databaseService.updateUserMultiStats(
          widget.senderId, widget.receiverId, widget.score);

      await _databaseService.updateSenderMultiPlayerGame(
          widget.multiPlayerGameId, false);

      await _databaseService.updateReceiverMultiPlayerGame(
          widget.multiPlayerGameId, false);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _updateStats(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('error');
            } else if (snapshot.hasData) {
              final _mutliPlayerGameDetails =
                  Provider.of<MultiPlayerGameModel?>(context);

              if (_mutliPlayerGameDetails != null &&
                  _mutliPlayerGameDetails.cancelled!) {
                return InitializerWidget();
              } else {
                return SafeArea(
                    child: Scaffold(
                  backgroundColor: backgroundColor,
                  body: Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                              flex: 1, fit: FlexFit.tight, child: SizedBox()),
                          widget.score == '1'
                              ? Text('Winner: ' + widget.senderUsername!)
                              : widget.score == '2'
                                  ? Text('Winner: ' + widget.receiverUsername!)
                                  : Text('Draw'),
                          Flexible(
                              flex: 1, fit: FlexFit.tight, child: SizedBox()),
                          widget.score == '1' && widget.senderHasProfilePic!
                              ? Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              widget.senderProfilePicUri!))),
                                )
                              : SizedBox(),
                          widget.score == '2' && widget.receiverHasProfilePic!
                              ? Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              widget.receiverProfilePicUri!))),
                                )
                              : SizedBox(),
                          Flexible(
                              flex: 1, fit: FlexFit.tight, child: SizedBox()),
                          GestureDetector(
                            onTap: () async {
                              if (widget.currUserId == widget.senderId) {
                                await _databaseService.resetMultiPlayerGame(
                                    widget.senderId,
                                    widget.receiverId,
                                    widget.senderHasProfilePic,
                                    widget.receiverHasProfilePic,
                                    widget.senderProfilePicUri,
                                    widget.receiverProfilePicUri,
                                    true,
                                    false);

                                /*Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoggedInMultiPlayer(
                                        widget.currUserId,
                                        widget.senderId,
                                        widget.receiverId,
                                        widget.senderUsername,
                                        widget.receiverUsername,
                                        widget.senderHasProfilePic,
                                        widget.receiverHasProfilePic,
                                        widget.senderProfilePicUri,
                                        widget.receiverProfilePicUri,
                                        widget.multiPlayerGameId)));*/
                              } else {
                                if (widget.currUserId == widget.receiverId &&
                                    _mutliPlayerGameDetails != null &&
                                    !_mutliPlayerGameDetails.cancelled! &&
                                    _mutliPlayerGameDetails.senderHasJoined!) 
                                    {
                                  await _databaseService
                                      .updateReceiverMultiPlayerGame(
                                          widget.multiPlayerGameId, true);

                                  /*Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoggedInMultiPlayer(
                                          widget.currUserId,
                                          widget.senderId,
                                          widget.receiverId,
                                          widget.senderUsername,
                                          widget.receiverUsername,
                                          widget.senderHasProfilePic,
                                          widget.receiverHasProfilePic,
                                          widget.senderProfilePicUri,
                                          widget.receiverProfilePicUri,
                                          widget.multiPlayerGameId)));*/
                                } else {
                                  SnackBar _snackBar = SnackBar(content: Text('Host has not joined yet'));
                                  ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                                }
                              }
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text('Play Again',
                                    style: TextStyle(color: Colors.white))),
                          ),
                          Flexible(
                              child: SizedBox(), flex: 1, fit: FlexFit.tight),
                          widget.currUserId == widget.senderId
                              ? GestureDetector(
                                  onTap: () async {
                                    await _databaseService
                                        .updateCancelMultiPlayerGame(
                                            widget.multiPlayerGameId);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          border: Border.all(color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text('Home',
                                          style:
                                              TextStyle(color: Colors.white))),
                                )
                              : SizedBox(),
                          widget.currUserId == widget.senderId
                              ? Flexible(
                                  child: SizedBox(),
                                  flex: 1,
                                  fit: FlexFit.tight)
                              : SizedBox()
                        ]),
                  ),
                ));
              }
            } else {
              return Text('No data');
            }
          } else {
            return Loading();
          }
        });
  }
}
