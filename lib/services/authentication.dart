
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseAuth {


  Future<String> googlesignin();
  Future<FirebaseUser> getCurrentUser();
  Future<bool> signOut();

}

    String name;
    String imageUrl;
    String email; 
    String uid;


  


class Auth implements BaseAuth {
    

  final firestoreInstance = Firestore.instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();


  Future<String> googlesignin() async{
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  
  final AuthResult authResult = await _firebaseAuth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;
          assert(user.email != null);    
          assert(user.displayName != null);  
          assert(user.photoUrl != null);

          name = user.displayName;
          email = user.email;
          imageUrl = user.photoUrl;

   firestoreInstance.collection("users").document(user.uid).setData(
  {
    "email": email,
    "name": name,
    "image": imageUrl
  });

  
  

  return user.uid;
  }



  
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
 

    
    
  return user;
  
  }
  Future<bool> signOut() async {
     _firebaseAuth.signOut();
     googleSignIn.signOut();
     return true;
  }
  
  
  }