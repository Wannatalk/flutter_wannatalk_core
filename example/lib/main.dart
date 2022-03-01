import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:wannatalkcore/wannatalkcore.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _userLoggedIn = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    Wannatalkcore.setMethodCallHandler(onReceivedEvent:(WTEventResponse eventResponse) {

      switch (eventResponse.eventType) {
        case WTEventResponse.kWTEventTypeProduct: {
          String? productID = eventResponse.result.productID;
          String? storeID = eventResponse.result.storeID;
          SystemNavigator.pop();
          break;
        }
      }

    });
  }

  // Platform messages are asynchronous, so we intialize in an async method.
  Future<void> initPlatformState() async {
    bool loggedIn = await Wannatalkcore.isUserLoggedIn;

    if (!mounted) return;

    WannatalkConfig.showGuideButton(false);
    WannatalkConfig.showProfileInfoPage(false);
    WannatalkConfig.allowSendAudioMessage(false);
    WannatalkConfig.allowAddParticipants(false);
    WannatalkConfig.enableAutoTickets(true);

    WannatalkConfig.showExitButton(true);
    WannatalkConfig.enableChatProfile(false);

    setState(() {
      _userLoggedIn = loggedIn;
    });
  }

  void login(){
    Wannatalkcore.login(onCompletion: (WTResult result) {
      if (result.success) {
        setState(() {
          _userLoggedIn = true;
        });
      }

    });
  }

  void silentLogin() {
    String userIdentifier = "+919000220455";
    Map userInfo = { "displayname": "SG"};

    Wannatalkcore.silentLogin(userIdentifier, userInfo, onCompletion: (WTResult result) {
      if (result.success) {
        setState(() {
          _userLoggedIn = true;
        });
      }
    });
  }


  void logout() {
    Wannatalkcore.logout(onCompletion: (WTResult result) {
      if (result.success) {
        setState(() {
          _userLoggedIn = false;
        });
      }
    });
  }


  void presentOrgProfile(bool autoOpenChat) {
    Wannatalkcore.loadOrganizationProfile(autoOpenChat, onCompletion: (WTResult result){
      if (result.success) {

      }
    });
  }

  void presentChats() {
    Wannatalkcore.loadChats(onCompletion: (WTResult result) {
      if (result.success) {

      }
    });
  }

  void presentUsers() {
    Wannatalkcore.loadUsers(onCompletion: (WTResult result) {
      if (result.success) {

      }
    });
  }


  void sendTextMessage() {
    String receiverUserIdentifier = "+60199299399499";
    Wannatalkcore.sendTextMessage(receiverUserIdentifier, "Hi", onCompletion: (WTResult result) {
      if (result.success) {

      }
    });
  }

  void sendProductImage() {
    String receiverUserIdentifier = "+60199299399499";

    WTChatInput chatInput = WTChatInput.Product("<productID>", "<productName>",
        "<productPrice>", "https://upload.wikimedia.org/wikipedia/commons/a/ab/Apple-logo.png",
        "<caption>", "<storeID>");
    Wannatalkcore.sendProductImage(receiverUserIdentifier, chatInput, onCompletion: (WTResult result) {
      if (result.success) {

      }
    });
  }

  void contactOrganization() {

    String orgID = "360";
    String channelID = "399";
    String message = "Hi";

    Wannatalkcore.contactOrganization(orgID, channelID, message, onCompletion: (WTResult result) {
      if (result.success) {

      }
    });
  }

  showAlertDialog(BuildContext context, String message) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () { },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Wannatalk Demo app'),
        ),
        body: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (!_userLoggedIn) new RaisedButton(
                onPressed: () {
                  login();
                },
                child: new Text('Login'),
              ),
              if (!_userLoggedIn) new RaisedButton(
                onPressed: () {
                  silentLogin();
                },
                child: new Text('Silent Login'),
              ),
              if (_userLoggedIn) new RaisedButton(
                onPressed: () {logout();},
                child: new Text('Logout'),
              ),
              if (_userLoggedIn) new RaisedButton(
                onPressed: () {presentOrgProfile(true);},
                child: new Text('Org Profile'),
              ),
              if (_userLoggedIn) new RaisedButton(
                onPressed: () {presentChats();},
                child: new Text('Chats'),
              ),
              if (_userLoggedIn) new RaisedButton(
                onPressed: () {presentUsers();},
                child: new Text('Users'),
              ),
              if (_userLoggedIn) new RaisedButton(
                onPressed: () {sendTextMessage();},
                child: new Text('Send Text Message'),
              ),
              if (_userLoggedIn) new RaisedButton(
                onPressed: () {sendProductImage();},
                child: new Text('Send Product Image'),
              ),
              if (_userLoggedIn) new RaisedButton(
                onPressed: () {contactOrganization();},
                child: new Text('Contact Organization'),
              )
            ],
          ),
        )
      ),
    );
  }

}

class FirstRoute extends StatelessWidget {
  const FirstRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Open route'),
          onPressed: () {
            // Navigate to second route when tapped.
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
