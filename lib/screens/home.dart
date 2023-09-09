import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/user_id_model.dart';
import 'package:tictactoepro/screens/authentication/authenticate.dart';
import 'package:tictactoepro/screens/multiPlayer/multi_choose_symbol.dart';
import 'package:tictactoepro/screens/singlePlayer/choose_symbol.dart';
import 'package:tictactoepro/services/auth_service.dart';
import 'package:tictactoepro/shared/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final _user = Provider.of<UserIdModel?>(context);

     return SafeArea(
        child: Scaffold(  
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.red,
          ),
          drawer: Drawer(
            
            child: Column(  
              children: [
                GestureDetector(

                  onTap: (){
                      
                      Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider.value(
                                value: _user,
                                child: Authenticate(),
                              ),
                            ),
                          );
                  },

                  child: ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Log In'),
                    
                  ),
                )
              ],
            ),
          ),
          body: Container(  
             width: double.infinity,
             height: double.infinity,
             margin: EdgeInsets.all(20),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Flexible(   
                  flex:2,
                  fit:FlexFit.tight,
                  child: SizedBox(),
                 ),

                 Text('TIC-TAC-TOE',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                 Text('PRO',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),

                 Flexible(   
                  flex:2,
                  fit:FlexFit.tight,
                  child: SizedBox(),
                 ),

                 GestureDetector(
                   onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(
                     builder: (context) => ChooseSymbol()));
                   },
                   child: Container(
                    decoration: BoxDecoration(  
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text('Single Player',style: TextStyle(color: Colors.white,fontSize: 16))),
                 ),

                 Flexible(   
                  flex:1,
                  fit:FlexFit.tight,
                  child: SizedBox(),
                 ),

                 GestureDetector(
                  onTap: () {
                     Navigator.of(context).push(MaterialPageRoute(
                     builder: (context) => MultiChooseSymbol()));
                   },
                   child: Container(
                    decoration: BoxDecoration(  
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text('Multi Player',style: TextStyle(color: Colors.white,fontSize: 16))),
                 ),

                  Flexible(   
                  flex:2,
                  fit:FlexFit.tight,
                  child: SizedBox(),
                 ),

                 Text('Developed by Tabish Shamim',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),

                 Flexible(   
                  flex:2,
                  fit:FlexFit.tight,
                  child: SizedBox(),
                 ),
             ]),
          ),
        ),
     );

  }
}