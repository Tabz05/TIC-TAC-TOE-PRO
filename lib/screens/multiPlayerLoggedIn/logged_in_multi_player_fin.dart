import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/multi_player_game_model.dart';
import 'package:tictactoepro/screens/multiPlayerLoggedIn/logged_in_multi_player_result.dart';
import 'package:tictactoepro/screens/multiPlayerLoggedIn/waiting.dart';
import 'package:tictactoepro/services/database_service.dart';
import 'package:tictactoepro/shared/colors.dart';

class LoggedInMultiPlayerFin extends StatefulWidget {

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

  LoggedInMultiPlayerFin(
      this.currUserId,
      this.senderId,
      this.receiverId,
      this.senderUsername,
      this.receiverUsername,
      this.senderHasProfilePic,
      this.receiverHasProfilePic,
      this.senderProfilePicUri,
      this.receiverProfilePicUri,
      this.multiPlayerGameId);

  @override
  State<LoggedInMultiPlayerFin> createState() => _LoggedInMultiPlayerFinState();
}

class _LoggedInMultiPlayerFinState extends State<LoggedInMultiPlayerFin> {
  final DatabaseService _databaseService = DatabaseService();

  final int _senderTurn = 1;
  final int _receiverTurn = 2;

  late List<String> _board;

  late bool _myTrn;

  late int _plTrn;

  late bool _gameOv;
  late String _winner;

  int gameOver() {
    //checking rows

    for (int i = 0; i <= 6; i += 3) {
      if (_board[i] == _board[i + 1] &&
          _board[i + 1] == _board[i + 2] &&
          _board[i] != '0') {
        print('row over');
        if (_board[i] == _senderTurn.toString()) {
          return 1;
        } else {
          return 2;
        }
      }
    }

    //checking columns

    for (int i = 0; i <= 2; i++) {
      if (_board[i] == _board[i + 3] &&
          _board[i + 3] == _board[i + 6] &&
          _board[i] != '0') {
        print('col over');
        if (_board[i] == _senderTurn.toString()) {
          return 1;
        } else {
          return 2;
        }
      }
    }

    //checking main diagonal

    if (_board[0] == _board[4] && _board[4] == _board[8] && _board[0] != '0') {
      print('main diag over');
      if (_board[0] == _senderTurn.toString()) {
        return 1;
      } else {
        return 2;
      }
    }

    //checking off diagonal

    if (_board[2] == _board[4] && _board[4] == _board[6] && _board[2] != '0') {
      print('off diag over');
      if (_board[2] == _senderTurn.toString()) {
        return 1;
      } else {
        return 2;
      }
    }

    //checking for draw

    int count = 0;

    for (int i = 0; i < 9; i++) {
      if (_board[i] != '0') {
        count += 1;
      }
    }

    if (count == 9) {
      print('draw');
      return 0;
    }

    return 3;
  }

  @override
  Widget build(BuildContext context) {

    final _mutliPlayerGameDetails = Provider.of<MultiPlayerGameModel?>(context);

    print('in game: ' + _mutliPlayerGameDetails.toString());

    if (_mutliPlayerGameDetails != null) {
      _board = _mutliPlayerGameDetails.board!;

      print("board is: " + _board.toString());

      if (_mutliPlayerGameDetails.turn == "s") {
        _plTrn = _senderTurn;
      }

      if (_mutliPlayerGameDetails.turn == "r") {
        _plTrn = _receiverTurn;
      }

      if (_mutliPlayerGameDetails.turn == "s" &&
          widget.currUserId == widget.senderId &&
          _mutliPlayerGameDetails.enableTap!) {
        _myTrn = true;
      }

      if (_mutliPlayerGameDetails.turn == "r" &&
          widget.currUserId == widget.receiverId &&
          _mutliPlayerGameDetails.enableTap!) {
        _myTrn = true;
      }

      _gameOv = _mutliPlayerGameDetails.gameOver!;
      _winner = _mutliPlayerGameDetails.winner!;

      print(_gameOv);
    }

    return _mutliPlayerGameDetails == null
        ? Waiting(widget.receiverUsername)
        : !_mutliPlayerGameDetails.receiverHasJoined! && !_gameOv && widget.currUserId==widget.senderId ? Waiting(widget.receiverUsername)
         : _gameOv || !_mutliPlayerGameDetails.receiverHasJoined! && !_gameOv && widget.currUserId==widget.receiverId
            ? LoggedInMultiPlayerResult(
                widget.currUserId,
                widget.senderId,
                widget.receiverId,
                widget.senderUsername,
                widget.receiverUsername,
                widget.senderHasProfilePic,
                widget.receiverHasProfilePic,
                widget.senderProfilePicUri,
                widget.receiverProfilePicUri,
                widget.multiPlayerGameId,
                _winner)
            : SafeArea(
                child: Scaffold(
                  backgroundColor: backgroundColor,
                  body: Container(
                    width: double.infinity,
                    height: double.infinity,
                    margin: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          widget.senderUsername! +
                              " v/s " +
                              widget.receiverUsername!,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 100),
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 3,
                            crossAxisSpacing: 3,
                            children: List.generate(9, (index) {
                              return GestureDetector(
                                onTap: () {
                                  _myTrn && _board[index] == '0'
                                      ? setState(
                                          () async {
                                            _myTrn = false;

                                            await _databaseService
                                                .updateMultiPlayerGame(
                                                    widget.multiPlayerGameId,
                                                    index,
                                                    _plTrn);

                                            // Wait for the update to complete before checking game over condition
                                            await Future.delayed(
                                                Duration(seconds: 1)); 

                                            int _score = gameOver();

                                            if (_score.toString() != '3') {
                                              await _databaseService
                                                  .updateMultiPlayerGameOver(
                                                widget.multiPlayerGameId,
                                                _score.toString(),
                                              );
                                              setState(() {
                                                _gameOv = true;
                                              });
                                            } else {
                                              await _databaseService
                                                  .updateEnableMultiPlayerGame(
                                                widget.multiPlayerGameId,
                                              );
                                            }
                                          },
                                        )
                                      : print('');
                                },
                                child: Container(
                                  child: _board[index] == '1'
                                      ? Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(),
                                              image: widget.senderHasProfilePic!
                                                  ? DecorationImage(
                                                      image: NetworkImage(widget
                                                          .senderProfilePicUri!),
                                                      fit: BoxFit.cover)
                                                  : DecorationImage(
                                                      image: AssetImage(
                                                          'assets/x.jpg'),
                                                      fit: BoxFit.cover)),
                                        )
                                      : _board[index] == '2'
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  image: widget
                                                          .receiverHasProfilePic!
                                                      ? DecorationImage(
                                                          image: NetworkImage(widget
                                                              .receiverProfilePicUri!),
                                                          fit: BoxFit.cover)
                                                      : DecorationImage(
                                                          image: AssetImage(
                                                              'assets/o.jpg'),
                                                          fit: BoxFit.cover)),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all()),
                                            ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}
