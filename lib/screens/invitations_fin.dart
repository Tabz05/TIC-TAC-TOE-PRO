import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/invite_sender_data_model.dart';
import 'package:tictactoepro/screens/invitation_tile.dart';
import 'package:tictactoepro/shared/colors.dart';
import 'package:tictactoepro/shared/loading.dart';

class InvitationsFin extends StatefulWidget {
  
  const InvitationsFin({super.key});

  @override
  State<InvitationsFin> createState() => _InvitationsFinState();
}

class _InvitationsFinState extends State<InvitationsFin> {
  @override
  Widget build(BuildContext context) {

    final _inviteList = Provider.of<List<InviteSenderDataModel>?>(context);

    return _inviteList==null? Loading() : SafeArea(
      child: Scaffold(  
        backgroundColor: backgroundColor,
        body: Container(  
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
          child: Column(  
            children: [
              SizedBox(height: 20,),
              _inviteList.length>0? Expanded(
                child: ListView.builder(
                              itemCount: _inviteList.length,
                              itemBuilder: (context, index) {
                                return InvitationTile(_inviteList[index]);
                              },
                            ),
              ) : Text('No Invitations')
            ],
          ),
        ),
      ));
  }
}