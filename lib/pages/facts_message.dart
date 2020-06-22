import 'package:flutter/material.dart';

import 'package:test_chatbot/pages/root_page.dart';
class Facts extends StatelessWidget {
  Facts({this.text, this.name, this.type});
 
  final String text;
  final String name;
  final bool type;

   // Widget _msg() {
      //  if (text.contains("http"))
       //      return Text(text,);
      //  else 
      //    return Image.network(text);     
      //}
      

  List<Widget> botMessage(context) {
    return <Widget>[
      Container(
        margin: const EdgeInsets.only(right: 10.0),
        child: CircleAvatar(child: Padding(
          padding: const EdgeInsets.all(5),
          child: Image.asset("assets/Logo_smile.png"),
        
        ),
         backgroundColor: Color.fromRGBO(255, 211, 42, 1.0), radius: 18,),
 ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
//            Text(this.name,
//                style: TextStyle(fontWeight: FontWeight.bold)),
            Card(
              color: Colors.white,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))
              ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: text.contains("http") ? Image.network(text) : Text(text, ),
                
                )
            ),

          ],
        ),
      ),
      
    ];
  }

  List<Widget> userMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
//            Text(this.name, style: Theme.of(context).textTheme.subhead),
            Card(
              color: Colors.blue[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  
                  child: Text(text, style: TextStyle(color: Colors.black),
                  ),
                ),
                
            ),
            
                          
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 10.0),
        child: CircleAvatar(child: Image.network(fimageUrl), backgroundColor: Colors.grey[200], radius: 12,),
      ),
    ];
  }
  
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? userMessage(context) : botMessage(context),
      ),
      
    );
  }
}