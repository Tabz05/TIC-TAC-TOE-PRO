import 'package:flutter/material.dart';
import 'package:tictactoepro/screens/multiPlayer/multi_player_game.dart';
import 'package:tictactoepro/shared/colors.dart';

class MultiChooseSymbol extends StatefulWidget {
  const MultiChooseSymbol({super.key});

  @override
  State<MultiChooseSymbol> createState() => _MultiChooseSymbolState();
}

class _MultiChooseSymbolState extends State<MultiChooseSymbol> {
  
  String _p1sym = 'X';

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
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              Text(
                "Choose player 1's symbol \n  (player 1 moves first)",
                style: TextStyle(fontSize: 16),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              Container(
                width: 150,
                child: RadioListTile(
                  title: Text('X'),
                  value: 'X',
                  groupValue: _p1sym,
                  onChanged: ((value) {
                    setState(() {
                      _p1sym = value.toString();
                    });
                  }),
                  activeColor: Colors.red,
                ),
              ),
              Container(
                width: 150,
                child: RadioListTile(
                  title: Text('O'),
                  value: 'O',
                  groupValue: _p1sym,
                  onChanged: ((value) {
                    setState(() {
                      _p1sym = value.toString();
                    });
                  }),
                  activeColor: Colors.red,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiPlayerGame(_p1sym)));
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Play!',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
            ]),
          )),
    );
  }
}
