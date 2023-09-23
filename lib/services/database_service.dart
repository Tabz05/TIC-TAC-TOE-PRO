import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tictactoepro/models/invite_receiver_data_model.dart';
import 'package:tictactoepro/models/invite_sender_data_model.dart';
import 'package:tictactoepro/models/multi_player_game_model.dart';
import 'package:tictactoepro/models/user_data_model.dart'; 

class DatabaseService {

  final String? uid;
  final String? usernameToSearch;
  final List<dynamic>? inviteList;
  final String? multiPlayerGameID;

  final UserDataModel? userDataModel;

  DatabaseService({this.uid,this.usernameToSearch,this.inviteList,this.multiPlayerGameID}) : userDataModel = UserDataModel(uid: uid);

  /*DatabaseService(
      {this.uid,
      this.usernameToSearch,
      this.inviteList,
      this.multiPlayerGameID});*/

  //collection reference (users)
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference _multiPlayerGameCollection =
      FirebaseFirestore.instance.collection("multiPlayerGames");

  //firebase storage profile pic reference
  Reference _firebaseStorageProfilePic =
      FirebaseStorage.instance.ref().child("profile pictures");

  //for creating user data
  Future createUserData(String username, String email) async {
    return await _userCollection.doc(uid).set({
      'uid': uid,
      'username': username,
      'email': email,
      'matches': 0,
      'won': 0,
      'lost': 0,
      'draw': 0,
      'first': 0,
      'second': 0,
      'wonFirst': 0,
      'wonSecond': 0,
      'multi_matches': 0,
      'multi_won': 0,
      'multi_lost': 0,
      'multi_draw': 0,
      'multi_first': 0,
      'multi_second': 0,
      'multi_wonFirst': 0,
      'multi_wonSecond': 0,
      'hasProfilePic': false,
      'profilePicUri': '',
      'invites': []
    });
  }

  //For updating user stats

  Future updateUserStats(String userId, String score, String playerTurn) async {
    if (score == '0' && playerTurn == 'First') 
    {
      await _userCollection.doc(userId).update({
        'matches': FieldValue.increment(1),
        'draw': FieldValue.increment(1),
        'first': FieldValue.increment(1),
      });
    } else if (score == '0' && playerTurn == 'Second') {
      await _userCollection.doc(userId).update({
        'matches': FieldValue.increment(1),
        'draw': FieldValue.increment(1),
        'second': FieldValue.increment(1),
      });
    } else if (score == '-1' && playerTurn == 'First') {
      await _userCollection.doc(userId).update({
        'matches': FieldValue.increment(1),
        'won': FieldValue.increment(1),
        'first': FieldValue.increment(1),
        'wonFirst': FieldValue.increment(1)
      });
    } else if (score == '-1' && playerTurn == 'Second') {
      await _userCollection.doc(userId).update({
        'matches': FieldValue.increment(1),
        'won': FieldValue.increment(1),
        'second': FieldValue.increment(1),
        'wonSecond': FieldValue.increment(1)
      });
    } else if (score == '1' && playerTurn == 'First') {
      await _userCollection.doc(userId).update({
        'matches': FieldValue.increment(1),
        'lost': FieldValue.increment(1),
        'first': FieldValue.increment(1),
      });
    } else if (score == '1' && playerTurn == 'Second') {
      await _userCollection.doc(userId).update({
        'matches': FieldValue.increment(1),
        'lost': FieldValue.increment(1),
        'second': FieldValue.increment(1),
      });
    }
  }

  //For updating username

  Future updateUsername(String userId, String username) async {
    await _userCollection.doc(userId).update({'username': username});
  }

  //user data from snapshot
  UserDataModel _userDataFromSnapshot(DocumentSnapshot snapshot, UserDataModel userDataModel){
    /*return UserDataModel(
        uid: uid,
        username: snapshot['username'] ?? '',
        email: snapshot['email'] ?? '',
        matches: snapshot['matches'] ?? 0,
        won: snapshot['won'] ?? 0,
        lost: snapshot['lost'] ?? 0,
        draw: snapshot['draw'] ?? 0,
        first: snapshot['first'] ?? 0,
        second: snapshot['second'] ?? 0,
        wonFirst: snapshot['wonFirst'] ?? 0,
        wonSecond: snapshot['wonSecond'] ?? 0,
        multi_matches: snapshot['multi_matches'] ?? 0,
        multi_won: snapshot['multi_won'] ?? 0,
        multi_lost: snapshot['multi_lost'] ?? 0,
        multi_draw: snapshot['multi_draw'] ?? 0,
        multi_first: snapshot['multi_first'] ?? 0,
        multi_second: snapshot['multi_second'] ?? 0,
        multi_wonFirst: snapshot['multi_wonFirst'] ?? 0,
        multi_wonSecond: snapshot['multi_wonSecond'] ?? 0,
        hasProfilePic: snapshot['hasProfilePic'] ?? false,
        profilePicUri: snapshot['profilePicUri'] ?? '',
        invites: (snapshot['invites'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            []);*/

  userDataModel.uid = snapshot['uid'] ?? userDataModel.uid;
  userDataModel.username = snapshot['username'] ?? '';
  userDataModel.email = snapshot['email'] ?? '';
  userDataModel.matches = snapshot['matches'] ?? 0;
  userDataModel.won = snapshot['won'] ?? 0;
  userDataModel.lost = snapshot['lost'] ?? 0;
  userDataModel.draw = snapshot['draw'] ?? 0;
  userDataModel.first = snapshot['first'] ?? 0;
  userDataModel.second = snapshot['second'] ?? 0;
  userDataModel.wonFirst = snapshot['wonFirst'] ?? 0;
  userDataModel.wonSecond = snapshot['wonSecond'] ?? 0;
  userDataModel.multi_matches = snapshot['multi_matches'] ?? 0;
  userDataModel.multi_won = snapshot['multi_won'] ?? 0;
  userDataModel.multi_lost = snapshot['multi_lost'] ?? 0;
  userDataModel.multi_draw = snapshot['multi_draw'] ?? 0;
  userDataModel.multi_first = snapshot['multi_first'] ?? 0;
  userDataModel.multi_second = snapshot['multi_second'] ?? 0;
  userDataModel.multi_wonFirst = snapshot['multi_wonFirst'] ?? 0;
  userDataModel.multi_wonSecond = snapshot['multi_wonSecond'] ?? 0;
  userDataModel.hasProfilePic = snapshot['hasProfilePic'] ?? false;
  userDataModel.profilePicUri = snapshot['profilePicUri'] ?? '';
  userDataModel.invites = (snapshot['invites'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
      [];

  // Notify listeners that data has changed
  userDataModel.updateNotify();

  return userDataModel;        
  }

  List<InviteReceiverDataModel> _inviteReceiverListFromSnapshot(
      QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return InviteReceiverDataModel(
          uid: doc.get("uid") ?? '',
          username: doc.get("username") ?? '',
          email: doc.get("email") ?? '',
          matches: doc.get("matches") ?? 0,
          won: doc.get("won") ?? 0,
          lost: doc.get("lost") ?? 0,
          draw: doc.get("draw") ?? 0,
          first: doc.get("first") ?? 0,
          second: doc.get("second") ?? 0,
          wonFirst: doc.get("wonFirst") ?? 0,
          wonSecond: doc.get("wonSecond") ?? 0,
          multi_matches: doc.get("multi_matches") ?? 0,
          multi_won: doc.get("multi_won") ?? 0,
          multi_lost: doc.get("multi_lost") ?? 0,
          multi_draw: doc.get("multi_draw") ?? 0,
          multi_first: doc.get("multi_first") ?? 0,
          multi_second: doc.get("multi_second") ?? 0,
          multi_wonFirst: doc.get("multi_wonFirst") ?? 0,
          multi_wonSecond: doc.get("multi_wonSecond") ?? 0,
          hasProfilePic: doc.get("hasProfilePic") ?? false,
          profilePicUri: doc.get("profilePicUri") ?? '',
          invites: (doc.get('invites') as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [],
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  List<InviteSenderDataModel> _inviteSenderListFromSnapshot(
      QuerySnapshot snapshot) {
    try {
      return snapshot.docs.map((doc) {
        return InviteSenderDataModel(
          uid: doc.get("uid") ?? '',
          username: doc.get("username") ?? '',
          email: doc.get("email") ?? '',
          matches: doc.get("matches") ?? 0,
          won: doc.get("won") ?? 0,
          lost: doc.get("lost") ?? 0,
          draw: doc.get("draw") ?? 0,
          first: doc.get("first") ?? 0,
          second: doc.get("second") ?? 0,
          wonFirst: doc.get("wonFirst") ?? 0,
          wonSecond: doc.get("wonSecond") ?? 0,
          multi_matches: doc.get("multi_matches") ?? 0,
          multi_won: doc.get("multi_won") ?? 0,
          multi_lost: doc.get("multi_lost") ?? 0,
          multi_draw: doc.get("multi_draw") ?? 0,
          multi_first: doc.get("multi_first") ?? 0,
          multi_second: doc.get("multi_second") ?? 0,
          multi_wonFirst: doc.get("multi_wonFirst") ?? 0,
          multi_wonSecond: doc.get("multi_wonSecond") ?? 0,
          hasProfilePic: doc.get("hasProfilePic") ?? false,
          profilePicUri: doc.get("profilePicUri") ?? '',
          invites: (doc.get('invites') as List<dynamic>?)
                  ?.map((e) => e.toString())
                  .toList() ??
              [],
        );
      }).toList();
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  //user data from snapshot
  MultiPlayerGameModel _multiPlayerGameDataFromSnapshot(
      DocumentSnapshot snapshot) {

    return MultiPlayerGameModel(
      multiPlayerGameId: multiPlayerGameID ?? '',
      sender: snapshot['sender'] ?? '',
      receiver: snapshot['receiver'] ?? '',
      turn: snapshot['turn'] ?? '',
      enableTap: snapshot['enableTap'] ?? false,
      gameOver: snapshot['gameOver'] ?? false,
      winner: snapshot['winner'] ?? '',
      senderHasJoined: snapshot['senderHasJoined'] ?? false,
      receiverHasJoined: snapshot['receiverHasJoined'] ?? false,
      cancelled: snapshot['cancelled'] ?? false,
      board: (snapshot['board'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
    );
  }

  //stream for getting user details
  Stream<UserDataModel?> get userDetails {
    print('over here');
    //return _userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);

    return _userCollection.doc(uid).snapshots().map((snapshot) {
       return _userDataFromSnapshot(snapshot, userDataModel!);
});
  }

  //stream for getting users
  Stream<List<InviteReceiverDataModel>> get getUsers {
    if (usernameToSearch != null && usernameToSearch!.isEmpty) {
      return _userCollection
          .where('uid', isNotEqualTo: uid!)
          .snapshots()
          .map(_inviteReceiverListFromSnapshot);
    } else {
      return _userCollection
          //.where('uid', isNotEqualTo: uid!)
          .where('username', isEqualTo: usernameToSearch)
          .snapshots()
          .map(_inviteReceiverListFromSnapshot);
    }
  }

  //stream for getting users
  Stream<List<InviteSenderDataModel>> get inviteSenderDetails {
    return _userCollection
        .where('uid', whereIn: inviteList)
        .snapshots()
        .map(_inviteSenderListFromSnapshot);
  }

  //stream for getting multi player game details
  Stream<MultiPlayerGameModel?>? get multiPlayerGameDetails {
    print('in streammmm: ' + multiPlayerGameID!);
    try {
      return _multiPlayerGameCollection
          .doc(multiPlayerGameID)
          .snapshots()
          .map(_multiPlayerGameDataFromSnapshot);
    } catch (e) {
      print("error: " + e.toString());
      return null; //returning null because the game might not exist
    }
  }

  //invitation

  Future sendInvite(String? sender, String? receiver) async {
    var inviteSender = [sender];

    return await _userCollection
        .doc(receiver)
        .update({'invites': FieldValue.arrayUnion(inviteSender)});
  }

  Future declineInvite(String? sender, String? receiver) async {
    var inviteSender = [sender];

    return await _userCollection
        .doc(receiver)
        .update({'invites': FieldValue.arrayRemove(inviteSender)});
  }

  Future createMultiPlayerGame(String? sender,String? receiver,bool? senderHasProfilePic,
  bool? receiverHasProfilePic,String? senderProfilePicUri,String? receiverProfilePicUri,bool? senderHasJoined,bool? receiverHasJoined)async {
    //remove invite

   // await declineInvite(sender,receiver);

    //creating multiplayer game

    return await _multiPlayerGameCollection.doc(sender! + receiver!).set({
      'multiPlayerGameId': sender + receiver,
      'sender': sender,
      'receiver': receiver,
      'turn': "s",
      'enableTap': true,
      'gameOver':false,
      'winner': "",
      'senderHasJoined':senderHasJoined,
      'receiverHasJoined':receiverHasJoined,
      'cancelled':false,
      'board': ['0', '0', '0', '0', '0', '0', '0', '0', '0'],
    });
  }

  Future resetMultiPlayerGame(String? sender,String? receiver,bool? senderHasProfilePic,
  bool? receiverHasProfilePic,String? senderProfilePicUri,String? receiverProfilePicUri,bool? senderHasJoined,bool? receiverHasJoined)async {

    try{

    return await _multiPlayerGameCollection.doc(sender! + receiver!).update({
      'multiPlayerGameId': sender + receiver,
      'sender': sender,
      'receiver': receiver,
      'turn': "s",
      'enableTap': true,
      'gameOver':false,
      'senderHasJoined':senderHasJoined,
      'receiverHasJoined':receiverHasJoined,
      'cancelled':false,
      'board': ['0', '0', '0', '0', '0', '0', '0', '0', '0'],
    });
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  Future updateMultiPlayerGame(String? multiplayerGameId, int index, int plTurn) async {

    await _multiPlayerGameCollection.doc(multiplayerGameId).update({'enableTap': false});

    if (plTurn == 1) 
    {
      await _multiPlayerGameCollection.doc(multiplayerGameId).update({'turn': "r"});

    } else
    {
      await _multiPlayerGameCollection.doc(multiplayerGameId).update({'turn': "s"});
    }

    final DocumentReference documentReference = _multiPlayerGameCollection.doc(multiplayerGameId);

    documentReference.get().then((documentSnapshot) {

      if (documentSnapshot.exists) {

        List<dynamic> array = (documentSnapshot['board'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [];

        array[index] = plTurn.toString();

        documentReference.update({
          'board': array,
        }).then((value) {
          print('Array field updated successfully!');
        }).catchError((error) {
          print('Failed to update array field: $error');
        });
      } else {
        print('Document does not exist.');
      }
    }).catchError((error) {
      print('Failed to retrieve document: $error');
    });
  }

  Future updateEnableMultiPlayerGame(String? multiplayerGameId) async {
    await _multiPlayerGameCollection
        .doc(multiplayerGameId)
        .update({'enableTap': true});
  }

  Future updateCancelMultiPlayerGame(String? multiplayerGameId) async {
    await _multiPlayerGameCollection
        .doc(multiplayerGameId)
        .update({'cancelled': true});
  }

  Future updateMultiPlayerGameOver(String? multiplayerGameId,String score) async {

    await _multiPlayerGameCollection
        .doc(multiplayerGameId)
        .update({'winner': score});  
    
    await _multiPlayerGameCollection
        .doc(multiplayerGameId)
        .update({'gameOver': true});    
  }

  Future updateReceiverMultiPlayerGame(String? multiplayerGameId,bool joined) async { 
    
    await _multiPlayerGameCollection
        .doc(multiplayerGameId)
        .update({'receiverHasJoined': joined});    
  }

  Future updateSenderMultiPlayerGame(String? multiplayerGameId,bool joined) async { 
    
    await _multiPlayerGameCollection
        .doc(multiplayerGameId)
        .update({'senderHasJoined': joined});    
  }

  //For deleting a multiplayer game

  Future deleteGame(String multiplayerGameId) async
  {
     await _multiPlayerGameCollection.doc(multiPlayerGameID).delete();
  }

  //For updating user stats after multiplayer game

  Future updateUserMultiStats(String? sender, String? receiver, String score) async {

    if (score == '0')
    {
      await _userCollection.doc(sender).update({
        'multi_matches': FieldValue.increment(1),
        'multi_draw': FieldValue.increment(1),
        'multi_first': FieldValue.increment(1),
      });

      await _userCollection.doc(receiver).update({
        'multi_matches': FieldValue.increment(1),
        'multi_draw': FieldValue.increment(1),
        'multi_second': FieldValue.increment(1),
      });
    } 
    else if (score == '1')
    {
      await _userCollection.doc(sender).update({
        'multi_matches': FieldValue.increment(1),
        'multi_won': FieldValue.increment(1),
        'multi_first': FieldValue.increment(1),
        'multi_wonFirst': FieldValue.increment(1),
      });

      await _userCollection.doc(receiver).update({
        'multi_matches': FieldValue.increment(1),
        'multi_lost': FieldValue.increment(1),
        'multi_second': FieldValue.increment(1),
      });

    } 
    else if (score == '2') 
    {
      await _userCollection.doc(sender).update({
        'multi_matches': FieldValue.increment(1),
        'multi_lost': FieldValue.increment(1),
        'multi_first': FieldValue.increment(1),
      });

      await _userCollection.doc(receiver).update({
        'multi_matches': FieldValue.increment(1),
        'multi_won': FieldValue.increment(1),
        'multi_second': FieldValue.increment(1),
        'multi_wonSecond': FieldValue.increment(1),
      });
    } 
  }

  Future uploadProfilePic(String userId, File imageFile) async {
    Reference _userProfilePic = _firebaseStorageProfilePic.child(userId);
    UploadTask _uploadTask = _userProfilePic.putFile(imageFile);

    TaskSnapshot _taskSnapshot = await _uploadTask.whenComplete(() {
      Future<String> _url = _userProfilePic.getDownloadURL();
    }).catchError((onError) {
      print(onError);
    });

    dynamic _profilePicUri = await _taskSnapshot.ref.getDownloadURL();

    await _userCollection.doc(userId).update({'hasProfilePic': true});
    await _userCollection.doc(userId).update({'profilePicUri': _profilePicUri});
  }
}
