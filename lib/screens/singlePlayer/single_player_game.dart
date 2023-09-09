import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tictactoepro/screens/singlePlayer/single_player_result.dart';
import 'package:tictactoepro/shared/colors.dart';

class SinglePlayerGame extends StatefulWidget {

  final String _playerSym;
  final String _playerTurn;

  SinglePlayerGame(this._playerSym, this._playerTurn);

  @override
  State<SinglePlayerGame> createState() => _SinglePlayerGameState();
}

class _SinglePlayerGameState extends State<SinglePlayerGame> {
  
  List<int> _board = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  bool _plTrn = true;
  bool _enableTap = true;

  final int _comp = 2;
  final int _plr = 1;

  int gameOver() {
    //checking rows

    for (int i = 0; i <= 6; i += 3) {
      if (_board[i] == _board[i + 1] &&
          _board[i + 1] == _board[i + 2] &&
          _board[i] != 0) {
        if (_board[i] == _plr) {
          return -1;
        } else {
          return 1;
        }
      }
    }

    //checking columns

    for (int i = 0; i <= 2; i++) {
      if (_board[i] == _board[i + 3] &&
          _board[i + 3] == _board[i + 6] &&
          _board[i] != 0) {
        if (_board[i] == _plr) {
          return -1;
        } else {
          return 1;
        }
      }
    }

    //checking main diagonal

    if (_board[0] == _board[4] && _board[4] == _board[8] && _board[0] != 0) {
      if (_board[0] == _plr) {
        return -1;
      } else {
        return 1;
      }
    }

    //checking off diagonal

    if (_board[2] == _board[4] && _board[4] == _board[6] && _board[2] != 0) {
      if (_board[2] == _plr) {
        return -1;
      } else {
        return 1;
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

  int emptyCells() {
    int count = 0;

    for (int i = 0; i < 9; i++) {
      if (_board[i] == 0) {
        count += 1;
      }
    }

    return count;
  }

  int _miniMax(bool maxipl) {
    int score = gameOver();

    int otherPlrScore;

    if (maxipl) {
      otherPlrScore = -1;
    } else {
      otherPlrScore = 1;
    }

    if (score == otherPlrScore) {
      if (maxipl) {
        return -1 * (emptyCells() + 1);
      } else {
        return 1 * (emptyCells() + 1);
      }
    }

    if (score == 0) {
      return score;
    }

    if (maxipl) {
      int bestsr = -999;

      for (int i = 0; i < 9; i++) {
        if (_board[i] == 0) {
          _board[i] = _comp;

          bestsr = max(bestsr, _miniMax(false));

          _board[i] = 0;
        }
      }

      return bestsr;
    } else {
      int bestsr = 999;

      for (int i = 0; i < 9; i++) {
        if (_board[i] == 0) {
          _board[i] = _plr;

          bestsr = min(bestsr, _miniMax(true));

          _board[i] = 0;
        }
      }

      return bestsr;
    }
  }

  void _compTurn() {
    int bestScore = -999;
    int bestPos = -1;

    for (int i = 0; i < 9; i++) {
      if (_board[i] == 0) {
        _board[i] = _comp;

        int a = _miniMax(false);

        if (a > bestScore) {
          bestScore = a;
          bestPos = i;
        }

        _board[i] = 0;
      }
    }

    setState(() {
      _board[bestPos] = _comp;
    });

    int _score = gameOver();

    _score != -2
        ? setState(
            () {
              _enableTap = false;
            },
          )
        : print('');

    _score != -2
        ? Timer(
            const Duration(seconds: 1),
            () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SinglePlayerResult(_score.toString(),
                      widget._playerSym, widget._playerTurn)));
            },
          )
        : print('');

    _plTrn = true;
  }

  @override
  void initState() {
    super.initState();

    if (widget._playerTurn == 'Second') {
      _plTrn = false;
      _compTurn();
    }
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
          child: Column(
            children: [
              Text(
                'Your symbol: ' + widget._playerSym + '\n',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height:100),
              Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    children: List.generate(9, (index) {
                      return GestureDetector(
                        onTap: () {
                          _plTrn && _board[index] == 0 && _enableTap
                              ? setState(
                                  () {
                                    _board[index] = _plr;
                                    _plTrn = false;
                
                                    int _score = gameOver();
                
                                    _score != -2
                                        ? setState(
                                            () {
                                              _enableTap = false;
                                            },
                                          )
                                        : print('');
                
                                    _score != -2
                                        ? Timer(
                                            const Duration(seconds: 1),
                                            () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SinglePlayerResult(
                                                              _score.toString(),
                                                              widget._playerSym,
                                                              widget
                                                                  ._playerTurn)));
                                            },
                                          )
                                        : Timer(
                                            const Duration(seconds: 1),
                                            () {
                                              _compTurn();
                                            },
                                          );
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
                                      image: widget._playerSym == 'X'
                                          ? AssetImage('assets/x.jpg')
                                          : AssetImage('assets/o.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : _board[index] == 2
                                  ? Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        image: DecorationImage(
                                          image: widget._playerSym == 'X'
                                              ? AssetImage('assets/o.jpg')
                                              : AssetImage('assets/x.jpg'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration:
                                          BoxDecoration(border: Border.all()),
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
