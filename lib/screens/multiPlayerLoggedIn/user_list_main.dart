import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/invite_receiver_data_model.dart';
import 'package:tictactoepro/models/user_data_model.dart';
import 'package:tictactoepro/screens/multiPlayerLoggedIn/user_list_tile.dart';
import 'package:tictactoepro/shared/loading.dart';

class UserListMain extends StatefulWidget {
  const UserListMain({super.key});

  @override
  State<UserListMain> createState() => _UserListMainState();
}

class _UserListMainState extends State<UserListMain> {
  @override
  Widget build(BuildContext context) {

    final _userList = Provider.of<List<InviteReceiverDataModel>?>(context) ?? [];
    
    return _userList==null? Loading() : Expanded(
      child: ListView.builder(
              itemCount: _userList.length,
              itemBuilder: (context,index){
                return UserListTile(_userList[index]);
              },
           ),
    );
  }
}