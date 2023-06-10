import 'package:flutter/material.dart';
import 'package:tictactoepro/screens/home.dart';
import 'package:tictactoepro/screens/multiPlayer/multi_player_game.dart';
import 'package:tictactoepro/shared/colors.dart';

class MultiPlayerResult extends StatefulWidget {
  
  final String _winner;
  final String _p1sym;

  MultiPlayerResult(this._winner,this._p1sym);

  @override
  State<MultiPlayerResult> createState() => _MultiPlayerResultState();
}

class _MultiPlayerResultState extends State<MultiPlayerResult> {

  String _winnerRes='';

  @override
  void initState() {
    super.initState();

    if (widget._winner == '1')
    {
       _winnerRes = 'Player 1 wins';
    }
    else if(widget._winner == '2')
    {
       _winnerRes = 'Player 2 wins';
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
          margin: EdgeInsets.all(20),
          child: Column(children: [
             
             Flexible(child: SizedBox(),fit:FlexFit.tight,flex:1),

             Text(_winnerRes,style: TextStyle(fontSize: 18),),

             Flexible(child: SizedBox(),fit:FlexFit.tight,flex:1),

             GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MultiPlayerGame(widget._p1sym)));
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
                child: Text('Play again!',style: TextStyle(color: Colors.white,fontSize: 16),),
               ),
             ),

             Flexible(child: SizedBox(),fit:FlexFit.tight,flex:1),

             GestureDetector(
              onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Home()));
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
                child: Text('Home',style: TextStyle(color: Colors.white,fontSize: 16),),
               ),
             ),

             Flexible(child: SizedBox(),fit:FlexFit.tight,flex:1),

          ]),
        ),
      ));
  }
}