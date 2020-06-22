import 'package:flutter/material.dart';
import 'package:test_chatbot/pages/dialog_flow.dart';
import 'package:test_chatbot/pages/login_page.dart';
import 'package:test_chatbot/services/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AuthStatus {
  NOT_DETERMINED,
  NOT_LOGGED_IN,
  LOGGED_IN,
}
  String fname;
  String fimageUrl;
  String femail;

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

      

  @override
  State<StatefulWidget> createState() => new _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  String _userId = "";


  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {

        if (user != null) {
          _userId = user?.uid;
         final firestoreInstance = Firestore.instance;
         firestoreInstance.collection("users").document(user.uid).get().then((value){
    
 
       print(fimageUrl);
       print(fname);
       print(femail);
       fimageUrl = value.data["image"];
       fname =  value.data["name"];
       femail =  value.data["email"];

      
      
    });
 
         
        }
        
               setState((){
                 authStatus =
            user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN;
             });       
    });
    
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      
        _userId = user.uid.toString();

         final firestoreInstance = Firestore.instance;
         firestoreInstance.collection("users").document(user.uid).get().then((value){
    
       print(fimageUrl);
       print(fname);
       print(femail);


    // if(fname!=null && femail !=null && fimageUrl!=null){

    //   setState(() {

    //   fimageUrl = value.data["image"];
    //   fname =  value.data["name"];
    //   femail =  value.data["email"];
    //   authStatus = AuthStatus.LOGGED_IN;


    // });

    // }
    });
    
      
    });

  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.NOT_LOGGED_IN;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.NOT_DETERMINED:
        return buildWaitingScreen();
        break;
      case AuthStatus.NOT_LOGGED_IN:
        return new LoginSignupPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.LOGGED_IN:
        if (_userId.length > 0 && _userId != null) {
          return new FlutterFactsChatBot(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else
          return buildWaitingScreen();
        break;
      default:
        return buildWaitingScreen();
    }
  }
}