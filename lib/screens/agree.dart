import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tictactoepro/init_wid.dart';

class Agreement extends StatefulWidget {
  const Agreement({super.key});

  @override
  State<Agreement> createState() => _AgreementState();
}

class _AgreementState extends State<Agreement> {
  @override
  Widget build(BuildContext context) {
       
    return SafeArea(
      child: Scaffold(  
        body: SingleChildScrollView(
          child: Container(  
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(  
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black)
            ),
            child: Column(children: [
               Text('User Policy',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),),
               SizedBox(height: 20,),
               Text('* Usernames must not be offensive/abusive'),
               SizedBox(height: 20,),
               Text('* Profile pictures must not be offensive'),
               SizedBox(height: 30,),
               GestureDetector(
                onTap: () async{
                    
                    SharedPreferences sp = await SharedPreferences.getInstance();
                    sp.setString('accept', 'yes');

                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => InitializerWidget()));
                },
                 child: Container(
                   padding: EdgeInsets.all(10),
                   decoration: BoxDecoration( 
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green
                   ),
                  child: Text('Accept',style: TextStyle(color: Colors.white),)),
               )
            ]),
          ),
        ),
      )
    );

  }
}