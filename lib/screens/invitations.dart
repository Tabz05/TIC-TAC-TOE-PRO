import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tictactoepro/models/invite_sender_data_model.dart';
import 'package:tictactoepro/models/user_data_model.dart';
import 'package:tictactoepro/screens/invitations_fin.dart';
import 'package:tictactoepro/services/database_service.dart';
import 'package:tictactoepro/shared/loading.dart';

class Invitations extends StatefulWidget {
  const Invitations({super.key});

  @override
  State<Invitations> createState() => _InvitationsState();
}

class _InvitationsState extends State<Invitations> {

  @override
  Widget build(BuildContext context) {

    final _userDetails = Provider.of<UserDataModel?>(context);

    List<dynamic> _inviteList = [];

    if(_userDetails!=null)
    {
       _inviteList = _userDetails.invites!.toList();
       _inviteList.add('#'); //need this because wherein clause cant work on empty lists
    }

    return _userDetails==null? Loading() : StreamProvider<List<InviteSenderDataModel>?>.value(
      catchError:(_,__)=>null,
      initialData: null,
      value: DatabaseService(inviteList:_inviteList).inviteSenderDetails,
      child: InvitationsFin()
    );
  }
}