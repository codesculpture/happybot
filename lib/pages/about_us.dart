import 'package:flutter/material.dart';
import 'package:test_chatbot/pages/dialog_flow.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 211, 42, 1.0),
        title: Text("About Us", style: TextStyle(fontFamily: 'Coiny',
        color: Colors.white),
        ),
        leading: IconButton(icon:
         Icon(Icons.arrow_back, color: Colors.white,), 
         
         onPressed:(){
         Navigator.of(context).pop();
        } ),
      ),
      body: Container(
       
        child: RichText(
          
          text:
        TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 30,fontWeight: FontWeight.w500),
          children: <TextSpan>[
            TextSpan(text: "Happybot is your virtual AI friend to whom you can share your feelings, Moments, excitement etc.." ),
            TextSpan(text: "Happybot is a AI chatbot, whatever happens it is always there for you. We always innovating to deliver best for you"),
            TextSpan(text: ""),
            TextSpan(text: "The Happybot has been developed by two software developers Aravind and Karthik"),
            TextSpan(text:  "For enquiry or suggestions"),
            TextSpan(text: "contact us:"),
            TextSpan(text: "koplition@gmail.com",)
          ]
        )
        ),

      ),
    );
  }
}