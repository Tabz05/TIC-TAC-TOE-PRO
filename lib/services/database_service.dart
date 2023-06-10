import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tictactoepro/models/user_data_model.dart';

class DatabaseService {
  
  final String? uid;

  DatabaseService({this.uid});

  //collection reference (users)
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection("users");

  //firebase storage profile pic reference
  Reference _firebaseStorageProfilePic = FirebaseStorage.instance.ref().child("profile pictures");

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
      'hasProfilePic': false,
      'profilePicUri': ''
    });
  }

  //For updating user stats

  Future updateUserStats(String userId, String score, String playerTurn) async {

    if (score == '0' && playerTurn == 'First') {

      await _userCollection.doc(userId).update({

        'matches': FieldValue.increment(1),
        'draw': FieldValue.increment(1),
        'first': FieldValue.increment(1),
      });
    }
    else if (score == '0' && playerTurn == 'Second') {

      await _userCollection.doc(userId).update({

        'matches': FieldValue.increment(1),
        'draw': FieldValue.increment(1),
        'second': FieldValue.increment(1),
      });
    }
    else if (score == '-1' && playerTurn == 'First') {

      await _userCollection.doc(userId).update({

        'matches': FieldValue.increment(1),
        'won': FieldValue.increment(1),
        'first': FieldValue.increment(1),
        'wonFirst': FieldValue.increment(1)
      });
    }
    else if (score == '-1' && playerTurn == 'Second') {

      await _userCollection.doc(userId).update({

        'matches': FieldValue.increment(1),
        'won': FieldValue.increment(1),
        'second': FieldValue.increment(1),
        'wonSecond': FieldValue.increment(1)
      });
    }
    else if (score == '1' && playerTurn == 'First') {

      await _userCollection.doc(userId).update({

        'matches': FieldValue.increment(1),
        'lost': FieldValue.increment(1),
        'first': FieldValue.increment(1),
      });
    }
    else if (score == '1' && playerTurn == 'Second') {

      await _userCollection.doc(userId).update({

        'matches': FieldValue.increment(1),
        'lost': FieldValue.increment(1),
        'second': FieldValue.increment(1),
      });
    }
  }

  //For updating username

  Future updateUsername(String userId,String username) async {

    await _userCollection.doc(userId).update({

        'username': username
      });
    
  }

  //user data from snapshot
  UserDataModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot);
    return UserDataModel(
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
        hasProfilePic: snapshot['hasProfilePic'] ?? false,
        profilePicUri: snapshot['profilePicUri'] ?? '');
  }

  //stream for getting user details
  Stream<UserDataModel?> get userDetails {
    print('over here');
    return _userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future uploadProfilePic(String userId,File imageFile) async {

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
