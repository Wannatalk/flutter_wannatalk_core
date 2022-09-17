import 'dart:async';

import 'package:flutter/services.dart';


class WTFontNames {

  String? regular;
  String? bold;
  String? light;
  String? medium;
  String? italic;

  WTFontNames.init() {

  }
}

class WTEventResponse {

  static const  String cWTEvent= "wt_event";
  static const  int kWTEventTypeLogin= 2001;
  static const  int kWTEventTypeLogout= 2002;
  // static const  int kWTEventTypeOrder= 2003;
  static const  int kWTEventTypeProduct= 2004;
  static const  int kWTEventTypeLoadStorePage= 2005;


  late int eventType;
  late WTResult result;

  WTEventResponse.init() {
    this.eventType = -1;
    this.result = new WTResult.init();
  }
}

class WTResult {
  late bool success;
  String? error;
  String? productID;
  String? storeID;
  String? sellerOrderID;
  String? buyerOrderID;
  String? userIdentifier;

  WTResult(this.success, this.error);

  WTResult.init() {
    this.success = false;
    this.error = null;
  }

}


class WTChatInput {

  String source = "";
  String? imagePath;
  String? caption;
  String? productID;
  String? productName;
  String? productPrice;
  String? storeID;
  String? orderBuyerRef;
  String? orderSellerRef;

  WTChatInput.init(String source) {
    this.source = source;
  }

  static WTChatInput Product(String productID, String productName,
      String productPrice, String imagePath,
      String caption, String storeID) {

    WTChatInput chatInput = WTChatInput.init("Product");
    chatInput.productID = productID;
    chatInput.productName = productName;
    chatInput.productPrice = productPrice;
    chatInput.imagePath = imagePath;
    chatInput.caption = caption;
    chatInput.storeID = storeID;
    return chatInput;
  }
}


class Wannatalkcore {
  static const MethodChannel _channel =
      const MethodChannel('wannatalkcore');


  static late Function(WTEventResponse eventResponse) _onReceivedEvent;
  // , {required Function(WTResult result) onCompletion}
  static void setMethodCallHandler({required Function(WTEventResponse eventResponse) onReceivedEvent}) {
    _onReceivedEvent = onReceivedEvent;
    _channel.setMethodCallHandler(_wtEvent);
  }

  static Future<void> _wtEvent(MethodCall call) async {
    WTEventResponse eventResponse = new WTEventResponse.init();

    try {

      int eventType = call.arguments["eventType"];
      bool success = call.arguments["success"] == 1 || call.arguments["success"] == true;
      String? error = call.arguments["error"];

      eventResponse.eventType = eventType;
      eventResponse.result.success = success;
      eventResponse.result.error = error;

      eventResponse.result.productID = call.arguments[_cProductID];
      eventResponse.result.storeID = call.arguments[_cStoreID];
      eventResponse.result.sellerOrderID = call.arguments[_cSellerOrderID];
      eventResponse.result.buyerOrderID = call.arguments[_cBuyerOrderID];
      eventResponse.result.userIdentifier = call.arguments[_cWTUserIdentifier];

    } on Exception catch (e) {
      print("Failed to login: '${e.toString()}'.");

    }
    finally {
      _onReceivedEvent(eventResponse);
    }
  }

  static const  String _cWTDefaultMethod= "wannatalkDefaultMethod";
  static const  String _cWTUpdateConfig= "updateConfig";
  static const  String _cWTIsUserLoggedIn= "isUserLoggedIn";


  static const  String _cWTMethodType= "methodType";
  static const  String _cWTArgs= "args";
  static const  String _cWTUsername= "username";
  static const  String _cWTLocalImagePath= "localImagePath";

  static const  String _cProductID= "productID";
  static const  String _cStoreID= "storeID";
  static const  String _cSellerOrderID= "sellerOrderID";
  static const  String _cBuyerOrderID= "buyerOrderID";



  static const  String _cWTAutoOpenChat= "autoOpenChat";
  static const  String _cWTAutoOpenChannelId= "autoOpenChannelId";
  static const  String _cWTUserIdentifier= "userIdentifier";
  static const  String _cWTUserInfo= "userInfo";


  static const  int _kWTLoginMethod= 1001;
  static const  int _kWTSilentLoginMethod= 1002;
  static const  int _kWTLogoutMethod= 1003;
  static const  int _kWTOrgProfileMethod= 1004;
  static const  int _kWTChatListMethod= 1005;
  static const  int _kWTUserListMethod= 1006;
  static const  int _kWTUpdateUserNameMethod= 1007;
  static const  int _kWTUpdateUserImageMethod= 1008;
  static const  int _kWTIsUserLoggedIn= 1009;
  static const  int _kWTLoadUserChat= 1010;
  static const  int _kWTLoadUserChatWithImage= 1011;
  static const  int _kWTContactOrg= 1012;


  static final  String _cISource= "Source";
  static final  String _cIImage= "Image";
  static final  String _cICaption= "Caption";
  static final  String _cIProductID= "ProductID";
  static final  String _cIProductName= "ProductName";
  static final  String _cIProductPrice= "ProductPrice";
  static final  String _cIStoreID= "StoreID";

  static final  String _cIOrgID= "orgID";
  static final  String _cIChannelID= "channelID";
  static final  String _cIMessage= "message";

  /// To check login status
  // static Future<bool> get isUserLoggedIn => _channel.invokeMethod(_cWTIsUserLoggedIn);
  static Future<bool> get isUserLoggedIn async {
    return await _channel.invokeMethod(_cWTIsUserLoggedIn);
  }
    
    
  /// To login into wannatalk account
  static Future<void> login({required Function(WTResult result) onCompletion}) async {
    _sendWannatalkMethod(_kWTLoginMethod, null, onCompletion: onCompletion);
  }

  /// To login into wannatalk account with user credentials
  static Future<void> silentLogin(String userIdentifier, Map userInfo, {required Function(WTResult result) onCompletion}) async {
    _sendWannatalkMethod(_kWTSilentLoginMethod, <String, dynamic>{_cWTUserIdentifier: userIdentifier, _cWTUserInfo: userInfo}, onCompletion: onCompletion);
  }

  /// To unlink Wannatalk account
  static Future<void> logout({required Function(WTResult result) onCompletion}) async {
    _sendWannatalkMethod(_kWTLogoutMethod, null, onCompletion: onCompletion);
  }
  /// To load your organization profile
  static Future<void> loadOrganizationProfile(bool autoOpenChat, int autoOpenChanenlId, {required Function(WTResult result) onCompletion}) async {
    _sendWannatalkMethod(_kWTOrgProfileMethod, <String, dynamic>{_cWTAutoOpenChat: autoOpenChat, _cWTAutoOpenChannelId: autoOpenChanenlId}, onCompletion: onCompletion);
  }
  /// To view all chats
  static Future<void> loadChats({required Function(WTResult result) onCompletion}) async {
    _sendWannatalkMethod(_kWTChatListMethod, null, onCompletion: onCompletion);
  }
  /// To view all users
  static Future<void> loadUsers({required Function(WTResult result) onCompletion}) async {
    _sendWannatalkMethod(_kWTUserListMethod, null, onCompletion: onCompletion);
  }

  /// To update user profile name
  static Future<void> updateUserName(String username, {required Function(WTResult result) onCompletion}) async {
    _sendWannatalkMethod(_kWTUpdateUserNameMethod, <String, dynamic>{_cWTUsername: username}, onCompletion: onCompletion);
  }

  /// To update user profile image
  static Future<void> updateUserImage(String localImagePath, {required Function(WTResult result) onCompletion}) async {
    _sendWannatalkMethod(_kWTUpdateUserImageMethod, <String, dynamic>{_cWTLocalImagePath: localImagePath}, onCompletion: onCompletion);
  }

//  static Future<String> _sendWannatalkMethod2(int kWTMethod, Object object, {Function(bool success, String error) onCompletion}) async {
//    String error = await _channel.invokeMethod(_cWTDefaultMethod, <String, dynamic>{_cWTMethodType: kWTMethod, _cWTArgs: object});
//    onCompletion(error == null, error);
//    return error;
//  }

  ///
  static Future<WTResult> _sendWannatalkMethod(int kWTMethod, Object? object, {required Function(WTResult result) onCompletion}) async {
    String? error = await _channel.invokeMethod(_cWTDefaultMethod, <String, dynamic>{_cWTMethodType: kWTMethod, _cWTArgs: object});
    WTResult result = new WTResult(error == null, error);
    onCompletion(result);
    return result;
  }

  ///
  static Future<void> _updateConfig(int kWTMethod, Object? object) async {
    _channel.invokeMethod(_cWTUpdateConfig, <String, dynamic>{_cWTMethodType: kWTMethod, _cWTArgs: object});
  }

  /// To send text message to user
  static Future<void> sendTextMessage(String receiverUserIdentifier, String message, {required Function(WTResult result) onCompletion}) async {
    _sendWannatalkMethod(_kWTLoadUserChat, <String, dynamic>{
      _cWTUserIdentifier: receiverUserIdentifier,
      _cIMessage: message
    }, onCompletion: onCompletion);
  }

  /// To send image message to user
  static Future<void> sendProductImage(String receiverUserIdentifier, WTChatInput chatInput, {required Function(WTResult result) onCompletion}) async {
    _sendWannatalkMethod(_kWTLoadUserChatWithImage, <String, dynamic>{
      _cWTUserIdentifier: receiverUserIdentifier,
      _cISource: chatInput.source,
      _cICaption: chatInput.caption,
      _cIImage: chatInput.imagePath,
      _cIProductID: chatInput.productID,
      _cIProductName: chatInput.productName,
      _cIProductPrice: chatInput.productPrice,
      _cIStoreID: chatInput.storeID
    }, onCompletion: onCompletion);
  }

  /// To contact organization
  static Future<void> contactOrganization(String orgID, String channelID, String message, {required Function(WTResult result) onCompletion}) async {
    _sendWannatalkMethod(_kWTContactOrg, <String, dynamic>{
      _cIOrgID: orgID,
      _cIChannelID: channelID,
      _cIMessage: message
    }, onCompletion: onCompletion);
  }

}

/// Configurables
class WannatalkConfig {

  static const  int _kWTConfigClearTempFolder = 9001;
  static const  int _kWTConfigSetInactiveChatTimeout = 9002;
  static const  int _kWTConfigShowGuideButton = 9003;
  static const  int _kWTConfigAllowSendAudioMessage = 9004;
  static const  int _kWTConfigAllowAddParticipant = 9005;
  static const  int _kWTConfigAllowRemoveParticipants = 9006;
  static const  int _kWTConfigShowWelcomePage = 9007;
  static const  int _kWTConfigShowProfileInfoPage = 9008;
  static const  int _kWTConfigEnableAutoTickets = 9009;
  static const  int _kWTConfigShowExitButton = 9010;
  static const  int _kWTConfigShowChatParticipants = 9011;
  static const  int _kWTConfigEnableChatProfile = 9012;
  static const  int _kWTConfigAllowModifyChatProfile = 9013;
  static const  int _kWTConfigSetAgentQueueInterval = 9014;

  static const  int _kWTConfigShowHomeButton= 9015;
  static const  int _kWTConfigSetChatHeaderColor= 9016;
  static const  int _kWTConfigSetChatTitleColor= 9017;
  static const  int _kWTConfigSetChatBGColor= 9018;
  static const  int _kWTConfigSetFontNames= 9019;


  static const  String _cEnable= "enable";
  static const  String _cShow= "show";
  static const  String _cAllow= "allow";
  static const  String _cValue= "value";
  static const  String _cTimeoutInterval = "timeoutInterval";
  static const  String _cTimeInterval = "timeInterval";

  /// To clear temp files
  static Future<void> clearTempFiles(bool show) async {
    Wannatalkcore._updateConfig(_kWTConfigClearTempFolder, null);
  }

  /// To set Inactive chat timeout:
  ///
  /// Chat session will end if user is inactive for timeout interval duration.
  /// If timeout interval is 0, chat session will not end automatically.
  /// The default timout interval is 1800 seconds (30 minutes).
  static Future<void> setInactiveChatTimeout(double interval) async {
    Wannatalkcore._updateConfig(_kWTConfigSetInactiveChatTimeout, <String, dynamic>{_cTimeoutInterval: interval});
  }

  /// To set interval to check available agent  // default = 20 seconds
  static Future<void> setAgentQueueInterval(double interval) async {
    Wannatalkcore._updateConfig(_kWTConfigSetAgentQueueInterval, <String, dynamic>{_cTimeInterval: interval});
  }

  /// To show or hide guide button
  static Future<void> showGuideButton(bool show) async {
    Wannatalkcore._updateConfig(_kWTConfigShowGuideButton, <String, dynamic>{_cShow: show});
  }
  /// To enable or disable sending audio message
  static Future<void> allowSendAudioMessage(bool allow) async {
    Wannatalkcore._updateConfig(_kWTConfigAllowSendAudioMessage, <String, dynamic>{_cAllow: allow});
  }

  /// To show or hide add participants option in new ticket page and chat item profile page
  static Future<void> allowAddParticipants(bool allow) async {
    Wannatalkcore._updateConfig(_kWTConfigAllowAddParticipant, <String, dynamic>{_cAllow: allow});
  }

  /// To show or hide remove participants option in chat item profile
  static Future<void> allowRemoveParticipants(bool allow) async {
    Wannatalkcore._updateConfig(_kWTConfigAllowRemoveParticipants, <String, dynamic>{_cAllow: allow});
  }

  /// To show or hide welcome message
  static Future<void> showWelcomeMessage(bool show) async {
    Wannatalkcore._updateConfig(_kWTConfigShowWelcomePage, <String, dynamic>{_cShow: show});
  }

  /// To show or hide Profile Info page
  static Future<void> showProfileInfoPage(bool show) async {
    Wannatalkcore._updateConfig(_kWTConfigShowProfileInfoPage, <String, dynamic>{_cShow: show});
  }

  /// To create auto tickets:
  /// Chat ticket will create automatically when auto tickets is enabled,
  /// otherwise default ticket creation page will popup
  static Future<void> enableAutoTickets(bool enable) async {
    Wannatalkcore._updateConfig(_kWTConfigEnableAutoTickets, <String, dynamic>{_cEnable: enable});
  }

  /// To show or hide chat exit button in chat page
  static Future<void> showExitButton(bool show) async {
    Wannatalkcore._updateConfig(_kWTConfigShowExitButton, <String, dynamic>{_cShow: show});
  }

  /// To show or hide participants in chat profile page
  static Future<void> showChatParticipants(bool show) async {
    Wannatalkcore._updateConfig(_kWTConfigShowChatParticipants, <String, dynamic>{_cShow: show});
  }

  /// To enable or disbale chat profile page
  static Future<void> enableChatProfile(bool enable) async {
    Wannatalkcore._updateConfig(_kWTConfigEnableChatProfile, <String, dynamic>{_cEnable: enable});
  }

  /// To allow modify in chat profile page
  static Future<void> allowModifyChatProfile(bool allow) async {
    Wannatalkcore._updateConfig(_kWTConfigAllowModifyChatProfile, <String, dynamic>{_cAllow: allow});
  }


  static Future<void> showHomeButton(bool value) async {
    Wannatalkcore._updateConfig(_kWTConfigShowHomeButton, <String, dynamic>{_cValue: value});
  }
  static Future<void> setChatHeaderColor(String value) async {
    Wannatalkcore._updateConfig(_kWTConfigSetChatHeaderColor, <String, dynamic>{_cValue: value});
  }
  static Future<void> setChatTitleColor(String value) async {
    Wannatalkcore._updateConfig(_kWTConfigSetChatTitleColor, <String, dynamic>{_cValue: value});
  }
  static Future<void> setChatBGColor(String value) async {
    Wannatalkcore._updateConfig(_kWTConfigSetChatBGColor, <String, dynamic>{_cAllow: value});
  }
  static Future<void> setFontNames(WTFontNames fontNames) async {
    Wannatalkcore._updateConfig(_kWTConfigSetFontNames, <String, dynamic?>{
      "regular": fontNames.regular,
      "bold": fontNames.bold,
      "italic": fontNames.italic,
      "medium": fontNames.medium,
      "italic": fontNames.italic,
    });
  }

}
