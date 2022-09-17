import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:wannatalkcore/wannatalkcore.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

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
          var result = eventResponse.result;

          if (result.success) {
            if (result.productID != null && result.storeID != null) {
              print("ProductID: " + result.productID!);
              print("StoreID: " + result.storeID!);
            }
          }
          else {
            // Error
            print(result.error);
          }



          break;
        }
        case WTEventResponse.kWTEventTypeLoadStorePage: {
          var result = eventResponse.result;

          if (result.success) {
            if (result.userIdentifier != null) {
              print("User PhoneNumber: " + result.userIdentifier!);
            }
          }
          else {
            // Error
            print(result.error);
          }
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

    WannatalkConfig.showExitButton(false);
    WannatalkConfig.showHomeButton(true);
    WannatalkConfig.enableChatProfile(false);
    WannatalkConfig.setChatHeaderColor("#1475a5");
    WannatalkConfig.setChatTitleColor("#FFFFFF");
    WannatalkConfig.setChatBGColor("#FFFFFF");



    if (Platform.isAndroid) {
      // Android-specific code
      var fontNames = WTFontNames.init();
      fontNames.regular = "montserrat_regular.ttf";
      fontNames.bold = "montserrat_bold.ttf";
      fontNames.medium = "montserrat_medium.ttf";
      fontNames.italic = "montserrat_light.ttf";
      fontNames.light = "montserrat_light.ttf";

      WannatalkConfig.setFontNames(fontNames);



    } else if (Platform.isIOS) {
      // iOS-specific code
      var fontNames = WTFontNames.init();
      fontNames.regular = "Montserrat-Regular";
      fontNames.bold = "Montserrat-Bold";
      fontNames.medium = "Montserrat-Medium";
      fontNames.italic = "Montserrat-Light";
      fontNames.light = "Montserrat-Light";

      WannatalkConfig.setFontNames(fontNames);


    }

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
    Wannatalkcore.loadOrganizationProfile(autoOpenChat, 0, onCompletion: (WTResult result){
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

    String receiverUserIdentifier = "+60199299399499";  // Receiver mobile number with calling code

    String message = "Hi"; // Message you want to send to user
    Wannatalkcore.sendTextMessage(receiverUserIdentifier, message, onCompletion: (WTResult result) {
      if (result.success) {

      }
    });
  }

  void sendProductImage() {
    String receiverUserIdentifier = "+60199299399499"; // Receiver mobile number with calling code

    String productID = "<productID>"; // Product identifier
    String productName = "<productName>"; // Optional // Product name
    String productPrice = "<productPrice>"; // Optional // Product price
    String productImageUrl = "https://upload.wikimedia.org/wikipedia/commons/a/ab/Apple-logo.png"; // Product image url
    String caption = "Can share details about this product?"; // caption will be sent to receiver along with image
    String storeID = "<storeID>"; // Store/Shop identifier

    WTChatInput chatInput = WTChatInput.Product(productID, productName,
        productPrice, productImageUrl,
        caption, storeID);

    Wannatalkcore.sendProductImage(receiverUserIdentifier, chatInput, onCompletion: (WTResult result) {
      if (result.success) {

      }
    });
  }

  void contactOrganization() {

    String orgID = "your_organization_id";
    String channelID = "your_chat_channel_id";
    String message = "Hi";

    Wannatalkcore.contactOrganization(orgID, channelID, message, onCompletion: (WTResult result) {
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
