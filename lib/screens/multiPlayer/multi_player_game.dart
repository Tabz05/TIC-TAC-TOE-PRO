import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tictactoepro/screens/multiPlayer/multi_player_result.dart';
import 'package:tictactoepro/shared/colors.dart';

class MultiPlayerGame extends StatefulWidget {
  final String _p1sym;
  MultiPlayerGame(this._p1sym);

  @override
  State<MultiPlayerGame> createState() => _MultiPlayerGameState();
}

class _MultiPlayerGameState extends State<MultiPlayerGame> {
  List<int> _board = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  int _pltrn = 1;
  bool _enableTap = true;

  int gameOver() {
    //checking rows

    for (int i = 0; i <= 6; i += 3) {
      if (_board[i] == _board[i + 1] &&
          _board[i + 1] == _board[i + 2] &&
          _board[i] != 0) {
        if (_board[i] == 1) {
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
          _board[i] != 0) {
        if (_board[i] == 1) {
          return 1;
        } else {
          return 2;
        }
      }
    }

    //checking main diagonal

    if (_board[0] == _board[4] && _board[4] == _board[8] && _board[0] != 0) {
      if (_board[0] == 1) {
        return 1;
      } else {
        return 2;
      }
    }

    //checking off diagonal

    if (_board[2] == _board[4] && _board[4] == _board[6] && _board[2] != 0) {
      if (_board[2] == 1) {
        return 1;
      } else {
        return 2;
      }
    }

    //checking for draw

    int count = 0;

    for (int i = 0; i < 9; i++) {
      if (_board[i] != 0) {
        count += 1;
      }
    }

    if (count == 9) {
      return 0;
    }

    return -2;
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.all(20),
          child: Column(children: [
            SizedBox(height:100),
            Expanded(
                child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              children: List.generate(9, (index) {
                return GestureDetector(
                  onTap: () {
                    _board[index] == 0 && _enableTap
                        ? _pltrn == 1
                            ? setState(
                                () {
                                  _board[index] = 1;
                                  _pltrn = 2;

                                  int _score = gameOver();

                                  _score!=-2? setState(() {
                                    _enableTap = false;
                                  },) : print(' ');

                                  _score != -2
                                      ? Timer(
                                          const Duration(seconds: 1),
                                          () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MultiPlayerResult(
                                                            _score.toString(),
                                                            widget._p1sym)));
                                          },
                                        )
                                      : print('');
                                },
                              )
                            : setState(
                                () {
                                  _board[index] = 2;
                                  _pltrn = 1;

                                  int _score = gameOver();

                                  _score!=-2? setState(() {
                                    _enableTap = false;
                                  },) : print(' ');

                                  _score != -2
                                      ? Timer(
                                          const Duration(seconds: 1),
                                          () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MultiPlayerResult(
                                                            _score.toString(),
                                                            widget._p1sym)));
                                          },
                                        )
                                      : print('');
                                },
                              )
                        : print('');
                  },
                  child: Container(
                    child: _board[index] == 1
                        ? Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                image: DecorationImage(
                                    image: widget._p1sym == 'X'
                                        ? AssetImage('assets/x.jpg')
                                        : AssetImage('assets/o.jpg'),
                                    fit: BoxFit.cover)),
                          )
                        : _board[index] == 2
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    image: DecorationImage(
                                        image: widget._p1sym == 'X'
                                            ? AssetImage('assets/o.jpg')
                                            : AssetImage('assets/x.jpg'),
                                        fit: BoxFit.cover)),
                              )
                            : Container(
                                decoration: BoxDecoration(border: Border.all()),
                              ),
                  ),
                );
              }),
            ))
          ]),
        ),
      ),
    );
  }
}
