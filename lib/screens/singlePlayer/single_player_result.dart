import 'package:flutter/material.dart';
import 'package:tictactoepro/screens/home.dart';
import 'package:tictactoepro/screens/singlePlayer/single_player_game.dart';
import 'package:tictactoepro/shared/colors.dart';

class SinglePlayerResult extends StatefulWidget {
  
  final String _winner;
  final String _playerSym;
  final String _playerTurn;

  SinglePlayerResult(this._winner,this._playerSym,this._playerTurn);

  @override
  State<SinglePlayerResult> createState() => _SinglePlayerResultState();
}

class _SinglePlayerResultState extends State<SinglePlayerResult> {

  String _winnerRes='';

  @override
  void initState() {
    super.initState();

    if (widget._winner == '-1')
    {
       _winnerRes = 'You Win';
    }
    else if(widget._winner == '1')
    {
       _winnerRes = 'You Lose';
    }
    else 
    {
       _winnerRes = 'Draw';
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
           margin: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
           child: Column(children: [
              
              Flexible(flex:1,fit:FlexFit.tight,child: SizedBox(),),

              Text(_winnerRes,style: TextStyle(fontSize: 18),),

              Flexible(flex:1,fit:FlexFit.tight,child: SizedBox(),),

              GestureDetector(
                onTap: (){ 
                  Navigator.of(context).push(MaterialPageRoute(
                     builder: (context) => SinglePlayerGame(widget._playerSym,widget._playerTurn)));
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 80,vertical: 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(  
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text('Play Again!',style:TextStyle(fontSize: 18,color: Colors.white))),
              ),
              
              Flexible(flex:1,fit:FlexFit.tight,child: SizedBox(),),

              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                     builder: (context) => Home()));
                },
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal:80,vertical: 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(  
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red
                  ),
                  padding: EdgeInsets.all(10),
                  child: Text('Home',style:TextStyle(fontSize: 18,color: Colors.white))),
              ),
              
              Flexible(flex:1,fit:FlexFit.tight,child: SizedBox(),),
           ]),
         ),
      )
       );
  }
}