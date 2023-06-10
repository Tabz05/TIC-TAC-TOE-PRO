import 'package:firebase_auth/firebase_auth.dart';
import 'package:tictactoepro/models/user_id_model.dart';
import 'package:tictactoepro/services/database_service.dart';

class AuthService{
    
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebase user

  UserIdModel? _userIdFromFirebaseUser(User? user)
  {
      if(user!=null)
      {
          return UserIdModel(uid:user.uid);
      }
      else
      {
          return null;
      }
  }

  //auth change stream

  Stream<UserIdModel?> get userId{
        
      return _auth.authStateChanges().map(_userIdFromFirebaseUser);
  }

  //sign in email pass

  Future signInEmailAndPassword(String email,String password) async{
    try{

      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      
      User? user = result.user;
      return _userIdFromFirebaseUser(user); //essential for form error handling to show error

    }catch(e)
    {
       print(e.toString());
       return null;
    }
  }

  //register email & pass

  Future registerWithEmailAndPassword(String email,String password,String username) async{
    try{

      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      
      //create firestore document for the user
      await DatabaseService(uid:user!.uid).createUserData(username,email);

      return _userIdFromFirebaseUser(user); //essential for form error handling to show error

    }catch(e)
    {
       print(e.toString());
       return null;
    }
  }

  //sign out

  Future signOut() async{
    try{
      return await _auth.signOut(); 
    }catch(e)
    {
       print(e.toString());
       return null;
    }
  }

}