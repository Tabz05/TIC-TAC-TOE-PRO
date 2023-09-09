import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/invite_receiver_data_model.dart';
import 'package:tictactoepro/models/user_data_model.dart';
import 'package:tictactoepro/screens/multiPlayerLoggedIn/logged_in_multi_player.dart';
import 'package:tictactoepro/services/database_service.dart';
import 'package:tictactoepro/shared/loading.dart';

class UserListTile extends StatefulWidget {
  
  final InviteReceiverDataModel inviteReceiverDataModel;
  
  UserListTile(this.inviteReceiverDataModel);

  @override
  State<UserListTile> createState() => _UserListTileState();
}

class _UserListTileState extends State<UserListTile> {

  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {

    final _userDetails = Provider.of<UserDataModel?>(context);

    return _userDetails==null? Loading() : (_userDetails.uid!)==(widget.inviteReceiverDataModel.uid!)? SizedBox() : GestureDetector(
      onTap: (() async{
         await _databaseService.sendInvite(_userDetails.uid,widget.inviteReceiverDataModel.uid);

         Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoggedInMultiPlayer(_userDetails.uid,_userDetails.uid,widget.inviteReceiverDataModel.uid,_userDetails.username,widget.inviteReceiverDataModel.username,_userDetails.hasProfilePic,widget.inviteReceiverDataModel.hasProfilePic,_userDetails.profilePicUri,widget.inviteReceiverDataModel.profilePicUri,_userDetails.uid!+widget.inviteReceiverDataModel.uid!)));
      }),
      child: Card(
            child: ListTile(
                leading: widget.inviteReceiverDataModel.hasProfilePic!? CircleAvatar(
                  backgroundImage: NetworkImage(widget.inviteReceiverDataModel.profilePicUri!),
                ) : CircleAvatar(
                  backgroundImage: AssetImage('assets/person.png'),
                  backgroundColor:Colors.red
                ),
                title: Text(widget.inviteReceiverDataModel.username!,style: TextStyle(fontSize: 16),),
            )
      ),
    );
  }
}