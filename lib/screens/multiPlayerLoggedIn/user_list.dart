import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/invite_receiver_data_model.dart';
import 'package:tictactoepro/models/user_data_model.dart';
import 'package:tictactoepro/screens/multiPlayerLoggedIn/user_list_main.dart';
import 'package:tictactoepro/services/database_service.dart';
import 'package:tictactoepro/shared/colors.dart';
import 'package:tictactoepro/shared/loading.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  String usernameToSearch="";

  @override
  Widget build(BuildContext context) {

    final _userDetails = Provider.of<UserDataModel?>(context);
  
    return _userDetails==null? Loading() : SafeArea(
      child: Scaffold(  
        backgroundColor: backgroundColor,
        body: Column(  
           children: [
             Container(
               width: double.infinity,
               margin: EdgeInsets.all(20),
               padding: EdgeInsets.all(5),
               decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.red),
                  color: Colors.white,
                ),
                child: TextField(
                  decoration: InputDecoration(  
                    hintText: 'Enter username...',
                    border: InputBorder.none,
                  ),
                  cursorColor: Colors.red,
                  onChanged: (value){
                     setState(() {
                       usernameToSearch = value;
                     });
                  },
                ),
             ),
             StreamProvider<List<InviteReceiverDataModel>?>.value(
              catchError:(_,__)=>null,
              initialData: null,
              value: DatabaseService(uid:_userDetails.uid,usernameToSearch:usernameToSearch).getUsers,
              child: UserListMain()),
           ],
        ),
      ));
  }
}