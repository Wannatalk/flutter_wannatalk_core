import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:wannatalkcore/wannatalkcore.dart';

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

  void presentUserChat(String identifier, String message) {
    Wannatalkcore.loadUserChat(identifier, message, onCompletion: (WTResult result){
      if (result.success) {

      }
    });
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
              )
            ],
          ),
        )
      ),
    );
  }

}
