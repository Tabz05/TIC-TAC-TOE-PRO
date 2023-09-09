import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/user_data_model.dart';
import 'package:tictactoepro/screens/home_log_in.dart';
import 'package:tictactoepro/screens/singlePlayerLoggedIn/log_in_single_player_game.dart';
import 'package:tictactoepro/shared/colors.dart';
import 'package:tictactoepro/shared/loading.dart';

class LogInSinglePlayerResult extends StatefulWidget {

  final String _winner;
  final String _playerTurn;

  LogInSinglePlayerResult(this._winner, this._playerTurn);

  @override
  State<LogInSinglePlayerResult> createState() =>
      _LogInSinglePlayerResultState();
}

class _LogInSinglePlayerResultState extends State<LogInSinglePlayerResult> {
  

  @override
  Widget build(BuildContext context) {

    final _userDetails = Provider.of<UserDataModel?>(context);

    return _userDetails==null? Loading() : SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox(),
          ),
          Text(
            widget._winner,
            style: TextStyle(fontSize: 18),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox(),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider.value(
                    value: _userDetails,
                    child: LogInSinglePlayerGame(widget._playerTurn),
                  ),
                ),
              );
            },
            child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 80, vertical: 0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.red),
                padding: EdgeInsets.all(10),
                child: Text('Play Again!',
                    style: TextStyle(fontSize: 18, color: Colors.white))),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox(),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangeNotifierProvider.value(
                    value: _userDetails,
                    child: HomeLogIn(_userDetails.uid!)
                  ),
                ),
              );
            },
            child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 80, vertical: 0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.red),
                padding: EdgeInsets.all(10),
                child: Text('Home',
                    style: TextStyle(fontSize: 18, color: Colors.white))),
          ),
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SizedBox(),
          ),
        ]),
      ),
    ));
  }
}
