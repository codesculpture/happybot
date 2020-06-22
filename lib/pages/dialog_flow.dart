import 'package:flutter/material.dart';
import 'package:test_chatbot/pages/facts_message.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:test_chatbot/pages/root_page.dart';
import 'package:flutter/rendering.dart';
import 'package:test_chatbot/services/authentication.dart';




class FlutterFactsChatBot extends StatefulWidget {
  FlutterFactsChatBot({Key key,this.auth, this.userId,this.logoutCallback,  this.title}) : super(key: key);
 
  final String title;
  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;
  




  @override
  State<StatefulWidget> createState() => new _FlutterFactsChatBotState();
}

class _FlutterFactsChatBotState extends State<FlutterFactsChatBot>{
  final List<Facts> messageList = <Facts>[];

final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  
  final TextEditingController _textController = new TextEditingController();


 @override
  void initState() {
    super.initState();
  }

     signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }
  void agentResponse(query) async {
    _textController.clear();
    AuthGoogle authGoogle =
    await AuthGoogle(fileJson: "assets/credentials.json").build();
    Dialogflow dialogFlow =
    Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogFlow.detectIntent(query);
    Facts message = Facts(
      text: response.getMessage() ??
          CardDialogflow(response.getListMessage()[0]).title,
      name: "HappyBot",
      type: false,
    );
    setState(() {
      messageList.insert(0, message);
    });
  }

  void _submitQuery(String text) {
    if(_textController.text.isEmpty){
      return null;
    }
    else{
    _textController.clear();
    Facts message = new Facts(
      text: text,
      name: "User",
      type: true,
    );
    setState(() {
      messageList.insert(0, message);
    });
    agentResponse(text);
    }
  }
  Widget _queryInputWidget(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
      child: Padding(
        padding: const EdgeInsets.only(left:8.0, right: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _submitQuery,
                decoration: InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
            
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send, color: Color.fromRGBO(255, 211, 42, 1.0),),
                  onPressed: () => _submitQuery(_textController.text)),
            ),
          ],
        ),
      ),
    );
    
  }




  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
          icon: Icon(Icons.filter_list,color: Colors.white,),
          onPressed: () =>_scaffoldKey.currentState.openDrawer() ,
        ),
        title: Text("Happybot", style: new TextStyle(
          fontFamily: 'Coiny', color: Colors.white,
        ),),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(255, 211, 42, 1.0),
        
      ),
      drawer:  new Drawer(
  
  child: new ListView(
    children: <Widget>[
      
     UserAccountsDrawerHeader(
       decoration: new BoxDecoration(
         color: Color.fromRGBO(255, 211, 42, 1.0),
       ),
       accountEmail: Text(femail),
       accountName: Text(fname),
       currentAccountPicture: CircleAvatar(

        backgroundImage: NetworkImage(fimageUrl),
       ),
       
     ),
          ListTile(
       title: Text("About Us"),
       
     ),
          ListTile(
       title: Text("Privacy Policy"),
     ),
     ListTile(
       title: Text("Signout"),
       onTap: signOut,
     ),
    ],
  )
      ),
          body: 
          Column(children: <Widget>[
             Flexible(
            
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
            
              reverse: true, //To keep the latest messages at the bottom
              itemBuilder: (_, int index) => messageList[index],
              itemCount: messageList.length,
            )),
        _queryInputWidget(context),
        
      ]
),
      
    );
 
  }

}

