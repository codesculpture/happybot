import 'package:flutter/material.dart';
import 'package:test_chatbot/services/authentication.dart';

class LoginSignupPage extends StatefulWidget {

   LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;


  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();

}

class _LoginSignupPageState extends State<LoginSignupPage>{



String _errorMessage;

 bool _isLoading;

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    
    super.initState();
  }

    void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    
      String userId = "";
      try {
        
          userId = await widget.auth.googlesignin();
          print('Signed in: $userId');
        
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          
        });
      }
    
  }

  


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       body: Stack(
          children: <Widget>[
             _showForm(),
            showCircularProgress(),
          ],
        )
    );
  }

  
Widget showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }



 Widget showPrimaryButton() {
    return OutlineButton(
      splashColor: Colors.yellow,
      onPressed: validateAndSubmit,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.yellow),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

Widget showLogo(){
   return new Container(
      width: 200,
      child: Row(
         mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Image(image: AssetImage("assets/Happybot-Login_page500x500.png"),height: 200,),
          
          ],
      ),
   );
}
Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0,),
        child: new Form(
         
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
            showLogo(),
            SizedBox(height: 100, ),
            showPrimaryButton(),
            showErrorMessage(),
            ],
          ),
        ));
  }

}