import 'package:flutter/material.dart';
import 'package:tictactoepro/screens/singlePlayer/single_player_game.dart';
import 'package:tictactoepro/shared/colors.dart';

class ChooseSymbol extends StatefulWidget {
  const ChooseSymbol({super.key});

  @override
  State<ChooseSymbol> createState() => _ChooseSymbolState();
}

class _ChooseSymbolState extends State<ChooseSymbol> {

  String _sym = "X";
  String _turn = "First";

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             
             Flexible(
               child: SizedBox(),
               flex:1,
               fit:FlexFit.tight
            ),

            Text('Choose your symbol',style:TextStyle(fontSize: 18)),

            Flexible(
               child: SizedBox(),
               flex:1,
               fit:FlexFit.tight
            ),

            Container(
              width: 200,
              child: RadioListTile(
                  title: Text('X'),
                  value: 'X', 
                  groupValue: _sym, 
                  onChanged: ((value) {
                     setState(() {
                       _sym = value.toString();
                     });
                  }),
                  activeColor: Colors.red,
                  ),
            ),
            

            Container(
              width: 200,
              child: RadioListTile(
                title: Text('O'),
                value: 'O', 
                groupValue: _sym, 
                onChanged: ((value) {
                    setState(() {
                      _sym = value.toString();
                    });
                }),
                activeColor: Colors.red,
                ),
                
            ),

            Flexible(
               child: SizedBox(),
               flex:1,
               fit:FlexFit.tight
            ),

            Text('Choose your turn',style:TextStyle(fontSize: 18)),

            Flexible(
               child: SizedBox(),
               flex:1,
               fit:FlexFit.tight
            ),

            Container(
              width: 200,
              child: RadioListTile(
                     title: Text('First'),
                      value: 'First', 
                      groupValue: _turn, 
                      onChanged: ((value) {
                         setState(() {
                           _turn = value.toString();
                         });
                      }),
                      activeColor: Colors.red,
              ),
            ),

            Container(
              width: 200,
              child: RadioListTile(
                  title: Text('Second'),
                  value: 'Second', 
                  groupValue: _turn, 
                  onChanged: ((value) {
                      setState(() {
                        _turn = value.toString();
                      });
                  }),
                  activeColor: Colors.red,
                  ),
            ),
            

            Flexible(
               child: SizedBox(),
               flex:1,
               fit:FlexFit.tight
            ),

            GestureDetector(
              onTap: () {

                 Navigator.of(context).push(MaterialPageRoute(
                     builder: (context) => SinglePlayerGame(_sym,_turn)));
              },
              child: Container(
                decoration: BoxDecoration(  
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red
                ),
                padding: EdgeInsets.all(10),
                child: Text('Play!',style:TextStyle(fontSize: 18,color: Colors.white))),
            ),

            Flexible(
               child: SizedBox(),
               flex:1,
               fit:FlexFit.tight
            ),

          ]),
 
         ) ,
       ),
    );
  }
}