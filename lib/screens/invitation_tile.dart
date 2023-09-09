import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/invite_sender_data_model.dart';
import 'package:tictactoepro/models/user_data_model.dart';
import 'package:tictactoepro/screens/multiPlayerLoggedIn/logged_in_multi_player.dart';
import 'package:tictactoepro/services/database_service.dart';
import 'package:tictactoepro/shared/loading.dart';

class InvitationTile extends StatefulWidget {
  
  final InviteSenderDataModel inviteSenderDataModel;
  InvitationTile(this.inviteSenderDataModel);

  @override
  State<InvitationTile> createState() => _InvitationTileState();
}

class _InvitationTileState extends State<InvitationTile> {

  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {

    final _userDetails = Provider.of<UserDataModel?>(context);

    return _userDetails==null? Loading() : Container(
      margin: EdgeInsets.symmetric(horizontal: 0,vertical: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(  
        borderRadius: BorderRadius.circular(8),
        color: Colors.white
      ),
      child: Column(
        children: [
          Row(children: [
            widget.inviteSenderDataModel.hasProfilePic!? CircleAvatar(
                        backgroundImage: NetworkImage(widget.inviteSenderDataModel.profilePicUri!),
                      ): CircleAvatar(backgroundImage: AssetImage('assets/person.png'),),
            SizedBox(width: 10,),
            Text(widget.inviteSenderDataModel.username!,style: TextStyle(fontSize: 16),)
          ],),
          SizedBox(height: 20,),
          Row(  
            children: [
               GestureDetector(
                 onTap: () async{
                    
                    if(widget.inviteSenderDataModel.hasProfilePic! && _userDetails.hasProfilePic!)
                    {
                      await _databaseService.createMultiPlayerGame(widget.inviteSenderDataModel.uid,_userDetails.uid,widget.inviteSenderDataModel.hasProfilePic!,_userDetails.hasProfilePic!,widget.inviteSenderDataModel.profilePicUri,_userDetails.profilePicUri,true,true);
                    }
                    else if(!widget.inviteSenderDataModel.hasProfilePic! && _userDetails.hasProfilePic!)
                    {
                      await _databaseService.createMultiPlayerGame(widget.inviteSenderDataModel.uid,_userDetails.uid,widget.inviteSenderDataModel.hasProfilePic!,_userDetails.hasProfilePic!,"",_userDetails.profilePicUri,true,true); 
                    }
                    else if(widget.inviteSenderDataModel.hasProfilePic! && !_userDetails.hasProfilePic!)
                    {
                      await _databaseService.createMultiPlayerGame(widget.inviteSenderDataModel.uid,_userDetails.uid,widget.inviteSenderDataModel.hasProfilePic!,_userDetails.hasProfilePic!,widget.inviteSenderDataModel.profilePicUri,"",true,true);
                    }
                    else 
                    {
                      await _databaseService.createMultiPlayerGame(widget.inviteSenderDataModel.uid,_userDetails.uid,widget.inviteSenderDataModel.hasProfilePic!,_userDetails.hasProfilePic!,"","",true,true);
                    }

                    Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoggedInMultiPlayer(_userDetails.uid,widget.inviteSenderDataModel.uid,_userDetails.uid,widget.inviteSenderDataModel.username,_userDetails.username,widget.inviteSenderDataModel.hasProfilePic,_userDetails.hasProfilePic,widget.inviteSenderDataModel.profilePicUri,_userDetails.profilePicUri,widget.inviteSenderDataModel.uid!+_userDetails.uid!)));
                    
                 },
                 child: Container( 
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(  
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.green
                  ), 
                  child: Text('ACCEPT',style: TextStyle(color: Colors.white),),
                 ),
               ),
               Flexible(  
                child: SizedBox(),
                flex: 1,
                fit:FlexFit.tight
               ),
               GestureDetector(
                 onTap: () async{
                   await _databaseService.declineInvite(widget.inviteSenderDataModel.uid,_userDetails.uid);
                 },
                 child: Container( 
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(  
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.red
                  ), 
                  child: Text('DECLINE',style: TextStyle(color: Colors.white),),
                 ),
               ),
            ],
          )
        ],
      ),
    );
  }
}