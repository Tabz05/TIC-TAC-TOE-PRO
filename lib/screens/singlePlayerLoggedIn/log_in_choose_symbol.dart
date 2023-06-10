import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/user_data_model.dart';
import 'package:tictactoepro/screens/singlePlayerLoggedIn/log_in_single_player_game.dart';
import 'package:tictactoepro/shared/colors.dart';

class LogInChooseSymbol extends StatefulWidget {
  const LogInChooseSymbol({super.key});

  @override
  State<LogInChooseSymbol> createState() => _LogInChooseSymbolState();
}

class _LogInChooseSymbolState extends State<LogInChooseSymbol> {

  String _turn = "First";

  @override
  Widget build(BuildContext context) {
    
    final _userDetails = Provider.of<UserDataModel?>(context);

    print("sym: "+_userDetails.toString());

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
                 
                 Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider.value(
                                value: _userDetails,
                                child: LogInSinglePlayerGame(_turn),
                              ),
                            ),
                          );
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