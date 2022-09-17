package com.wannatalk.wannatalkcore;


import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;

import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import wannatalk.wannatalksdk.WTCore.Interface.IWTLoginManager;
import wannatalk.wannatalksdk.WTCore.Interface.IWTCompletion;
import wannatalk.wannatalksdk.WTCore.WTSDKManager;
import wannatalk.wannatalksdk.WTCore.WTSDKConstants;
import wannatalk.wannatalksdk.WTLogin.WTLoginManager;
import wannatalk.wannatalksdk.WTChat.IWTChatLoader;
import wannatalk.wannatalksdk.WTChat.WTChatLoader;
import wannatalk.wannatalksdk.WTCore.Interface.IWTSDKCallbacks;
import wannatalk.wannatalksdk.WTChat.ChatInputData;

import android.text.TextUtils;
import android.util.Log;

import android.app.Activity;
import android.os.Bundle;

import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

/** WannatalkcorePlugin */
public class WannatalkcorePlugin implements FlutterPlugin, ActivityAware, MethodCallHandler {

  private static WannatalkcorePlugin plugin;
  private static MethodChannel channel;
  static Activity sActivity;

  public WannatalkcorePlugin() {
    // All Android plugin classes must support a no-args
    // constructor. A no-arg constructor is provided by
    // default without declaring one, but we include it here for
    // clarity.
    //
    // At this point your plugin is instantiated, but it
    // isn't attached to any Flutter experience. You should not
    // attempt to do any work here that is related to obtaining
    // resources or manipulating Flutter.
  }


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {

    if (channel == null || plugin == null) {

      channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "wannatalkcore");
//      channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "wannatalkcore");
      plugin = new WannatalkcorePlugin();
      channel.setMethodCallHandler(plugin);
      plugin.initialize();
    }

  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
//  private static void registerWith(Registrar registrar) {
//    if (channel == null || plugin == null) {
//      channel = new MethodChannel(registrar.messenger(), "wannatalkcore");
//      plugin = new WannatalkcorePlugin();
//      channel.setMethodCallHandler(plugin);
//      plugin.initialize();
//    }
//  }

  void initialize() {
    // Context context = getApplicationContext();
//    final Application applicationContext = (Application) this.reactContext.getApplicationContext();


    WTLoginManager.setIwtLoginManager(iwtLoginManager);
    WTSDKManager.SetIwtsdkCallbacks(iwtsdkCallbacks);
  }

  // IN
  static final  String _cWTDefaultMethod= "wannatalkDefaultMethod";
  static final  String _cWTUpdateConfig= "updateConfig";
  static final  String _cWTIsUserLoggedIn= "isUserLoggedIn";


  static final  String _cWTMethodType= "methodType";
  static final  String _cWTArgs= "args";
  static final  String _cWTUsername= "username";
  static final  String _cWTLocalImagePath= "localImagePath";

  static final  String _cWTAutoOpenChat= "autoOpenChat";
  static final  String _cWTAutoOpenChannelId= "autoOpenChannelId";
  static final  String _cWTUserIdentifier= "userIdentifier";
  static final  String _cWTUserInfo= "userInfo";
//  static final  String _cWTChatMessage= "chatMessage";

  static final  int _kWTLoginMethod= 1001;
  static final  int _kWTSilentLoginMethod= 1002;
  static final  int _kWTLogoutMethod= 1003;
  static final  int _kWTOrgProfileMethod= 1004;
  static final  int _kWTChatListMethod= 1005;
  static final  int _kWTUserListMethod= 1006;
  static final  int _kWTUpdateUserNameMethod= 1007;
  static final  int _kWTUpdateUserImageMethod= 1008;
  static final  int _kWTIsUserLoggedIn= 1009;
  static final  int _kWTLoadUserChat= 1010;
  static final  int _kWTLoadUserChatWithImage= 1011;
  static final  int _kWTContactOrg= 1012;

  // OUT

  static final  String _cMethod= "wt_event";
  static final  String _cEventType= "eventType";
  static final  String _cSuccess= "success";
  static final  String _cError= "error";

  static final  String _cProductID= "productID";
  static final  String _cStoreID= "storeID";
  static final  String _cSellerOrderID= "sellerOrderID";
  static final  String _cBuyerOrderID= "buyerOrderID";


  static final  String _cISource= "Source";
  static final  String _cIImage= "Image";
  static final  String _cICaption= "Caption";
  static final  String _cIProductID= "ProductID";
  static final  String _cIProductName= "ProductName";
  static final  String _cIProductPrice= "ProductPrice";
  static final  String _cIStoreID= "StoreID";

  static final  String _cIOrgID= "orgID";
  static final  String _cIChannelID= "channelID";
  static final  String _cITicketName= "ticketName";
  static final  String _cICloseOldTickets= "closeOldTickets";
  static final  String _cIMessage= "message";


  static final  int kWTEventTypeLogin= 2001;
  static final  int kWTEventTypeLogout= 2002;
  static final  int kWTEventTypeOrder= 2003;
  static final  int kWTEventTypeProduct= 2004;
  static final  int kWTEventTypeStore= 2005;

//  Activity activity;

  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding) {
//    activity = binding.getActivity();
    sActivity = binding.getActivity();

  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {

  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {

//    activity = activityPluginBinding.getActivity();
    sActivity = activityPluginBinding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
//    activity = null;
    sActivity = null;
  }

  public void onHandleMethodType(int methodType, Map<String, Object> args, @NonNull Result result) {
    switch (methodType) {
      case _kWTLoginMethod: {
        login(result);
        break;
      }
      case _kWTSilentLoginMethod: {
        String identifier = (String) args.get(_cWTUserIdentifier);
        Map<String, String> userInfo = (Map<String, String>) args.get(_cWTUserInfo);
        silentLogin(identifier, userInfo, result);
        break;
      }
      case _kWTLogoutMethod: {
        logout(result);
        break;
      }
      case _kWTOrgProfileMethod: {
        boolean autoOpenChat = (boolean) args.get(_cWTAutoOpenChat);
        int autoOpenChannelId = (int) args.get(_cWTAutoOpenChannelId);

        loadOrganizationProfile(autoOpenChat, autoOpenChannelId, result);
        break;
      }
      case _kWTChatListMethod: {
        loadChatList(result);
        break;
      }
      case _kWTUserListMethod: {
        loadUsers(result);
        break;
      }
      case _kWTUpdateUserNameMethod: {
        String username = (String) args.get(_cWTUsername);
        updateUserName(username, result);
        break;
      }
      case _kWTUpdateUserImageMethod: {
        String localImagePath = (String) args.get(_cWTLocalImagePath);
        updateUserImage(localImagePath, result);
        break;
      }
      case _kWTLoadUserChat: {
        String identifier = (String) args.get(_cWTUserIdentifier);
        String message = (String) args.get(_cIMessage);
        loadUserChat(identifier, message, result);
        break;
      }
      case _kWTLoadUserChatWithImage: {
        loadUserChatWithImage(args, result);
        break;
      }
      case _kWTContactOrg: {
        contactOrganization(args, result);
        break;
      }

      default: {
        result.notImplemented();
        break;
      }
    }
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals(_cWTDefaultMethod)) {
      Map<String, Object> mainArgs = (Map<String, Object>) call.arguments;

      int methodType = (int) mainArgs.get(_cWTMethodType);
      Map<String, Object> args = (Map<String, Object>) mainArgs.get(_cWTArgs);
      onHandleMethodType(methodType, args, result);
    }
    else if (call.method.equals(_cWTUpdateConfig)) {
      Map<String, Object> mainArgs = (Map<String, Object>) call.arguments;

      int methodType = (int) mainArgs.get(_cWTMethodType);
      Map<String, Object> args = (Map<String, Object>) mainArgs.get(_cWTArgs);
      WTConfigHandler.HandleMethodType(methodType, args, result);
    }
    else if (call.method.equals(_cWTIsUserLoggedIn)) {

      Boolean loggedIn = isUserLoggedIn();
      result.success(loggedIn );
    }
    else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }



  public Boolean isUserLoggedIn() {
    return WTLoginManager.IsUserLoggedIn();
  }

  Activity getActivity() {

    return sActivity;
  }

  Result loginResult;
  Result logoutResult;
  void login(Result result) {
    loginResult = result;

    Activity currentActivity = getActivity();
    if (currentActivity != null) {
      WTLoginManager.StartLoginActivity(currentActivity);
    }
    else {
      sendLoginCallback("Unable to get the context");
    }
  }


  void silentLogin(final String identifier, final Map<String, String> userInfo, Result result) {
    loginResult = result;
    // Silent authentication without otp verification

    Activity currentActivity = getActivity();
    if (currentActivity != null) {
      Bundle bundle = new Bundle();
      if (userInfo != null) {
        for (Map.Entry<String,String> entry : userInfo.entrySet()) {
          String key = entry.getKey();
          String value = entry.getValue();
          bundle.putString(key, value);
        }
      }

      WTLoginManager.SilentLoginActivity(identifier, bundle, currentActivity);
    }
    else {
      sendLoginCallback("Unable to get the context");
    }



  }


  void logout(Result result) {
    logoutResult = result;
    Activity currentActivity = getActivity();
    if (currentActivity != null) {
      WTLoginManager.Logout(currentActivity);
    }
    else {
      sendLogoutCallback("Unable to get the context");
    }
  }

  void loadOrganizationProfile(Boolean autoOpenChat, int autoOpenChannelId, final Result result) {
    // Load organization profile
    Activity currentActivity = getActivity();
    if (currentActivity != null) {
      WTSDKManager.LoadOrganizationActivity(currentActivity, autoOpenChat, autoOpenChannelId, new IWTCompletion() {
        @Override
        public void onCompletion(boolean success, String error) {
          if (success) {
            if (result != null) {
              result.success(null);
            }
          }
          else {
            if (result != null) {
              result.success(error);
            }
          }

        }
      });
    }
    else {
      if (result != null) {
        result.success("Unable to get the context");
      }

    }

  }


  void loadChatList(final Result result) {
    // Load chat list
    Activity currentActivity = getActivity();
    if (currentActivity != null) {
      WTSDKManager.LoadChatListActivity(currentActivity, new IWTCompletion() {
        @Override
        public void onCompletion(boolean success, String error) {
          if (success) {
            if (result != null) {
              result.success(null);
            }
          }
          else {
            if (result != null) {
              result.success(error);
            }
          }
        }
      });

    }
    else {
      if (result != null) {
        result.success("Unable to get the context");
      }

    }
  }


  void loadUsers(final Result result) {
    // Load users
    Activity currentActivity = getActivity();
    if (currentActivity != null) {
      WTSDKManager.LoadUsersActivity(currentActivity, new IWTCompletion() {
        @Override
        public void onCompletion(boolean success, String error) {
          if (success) {
            if (result != null) {
              result.success(null);
            }
          }
          else {
            if (result != null) {
              result.success(error);
            }
          }
        }
      });

    }
    else {
      if (result != null) {
        result.success("Unable to get the context");
      }

    }
  }


  void loadUserChat(String identifier, String message, final Result result) {
    // Load users

    final Activity currentActivity = getActivity();
    if (currentActivity != null && !TextUtils.isEmpty(identifier)) {


      WTChatLoader chatLoader = new WTChatLoader(new IWTChatLoader() {
        @Override
        public void showSpinner(boolean show) {
//                showProgressInd(show);
        }

        @Override
        public void onCompletion(String error) {
//          Log.e(TAG, "onCompletion: " + topic + " error:" + error);
          if (error == null) {
            if (result != null) {
              result.success(null);
            }
          }
          else {
            if (TextUtils.isEmpty(error)) {
              error = "Something went wrong. Please try again";
            }
            if (result != null) {
              result.success(error);
            }

          }

        }

        @Override
        public Activity getParentActivity() {
          return currentActivity;
        }
      });

      chatLoader.loadUserChatPage(identifier, message);

    }
    else {
      if (result != null) {
        result.success("Unable to get the context");
      }

    }
  }

  void contactOrganization(Map<String, Object> args, final Result result) {

    String message = (String) args.get(_cIMessage);
    String sOrgID = (String) args.get(_cIOrgID);
    String sChannelID = (String) args.get(_cIChannelID);
    String ticketName = (String) args.get(_cITicketName);
    boolean closeOldTickets = (boolean) args.get(_cICloseOldTickets);
    Integer orgID = Integer.valueOf(sOrgID);
    Integer channelID = Integer.valueOf(sChannelID);

    final Activity currentActivity = getActivity();
    if (currentActivity == null) {
      if (result != null) {
        result.success("Unable to get the context");
      }
      return;
    }

    WTChatLoader.sendMessage(message, orgID, channelID, ticketName, closeOldTickets);

    if (result != null) {
      result.success(null);
    }

  }

  void loadUserChatWithImage(Map<String, Object> args, final Result result) {


    final Activity currentActivity = getActivity();
    if (currentActivity == null) {
      if (result != null) {
        result.success("Unable to get the context");
      }
      return;
    }



    WTChatLoader chatLoader = new WTChatLoader(new IWTChatLoader() {
      @Override
      public void showSpinner(boolean show) {
//                showProgressInd(show);
      }

      @Override
      public void onCompletion(String error) {
//        Log.e(TAG, "onCompletion error:" + error);
        if (error == null) {
          if (result != null) {
            result.success(null);
          }
        }
        else {
          if (TextUtils.isEmpty(error)) {
            error = "Something went wrong. Please try again";
          }
          if (result != null) {
            result.success(error);
          }

        }
      }

      @Override
      public Activity getParentActivity() {
        return currentActivity;
      }
    });

    String wtUserIdentifier = (String) args.get(_cWTUserIdentifier);
    ChatInputData chatInputData = new ChatInputData();

    chatInputData.source = (String) args.get(_cISource);
    chatInputData.imagePath = (String) args.get(_cIImage);
    chatInputData.caption = (String) args.get(_cICaption);
    chatInputData.productID = (String) args.get(_cIProductID);
    chatInputData.productName = (String) args.get(_cIProductName);
    chatInputData.productPrice = (String) args.get(_cIProductPrice);
    chatInputData.storeID = (String) args.get(_cIStoreID);;

    chatLoader.loadUserChatWithChatInputData(chatInputData, wtUserIdentifier);
  }

//  //
//  // private static void sendNotification(RemoteMessage remoteMessage, Context
//  // context) {
//  // WTBaseSDKManager.SendNotification(remoteMessage, context);
//  // }
//
//  //
//  // private static void SetDeviceToken(String deviceToken) {
//  // WTBaseSDKManager.SetDeviceToken(deviceToken);
//  // }

  private static void updateUserImage(String localImagePath, final Result result) {
    WTLoginManager.UploadUserImageAtPath(localImagePath, new IWTCompletion() {
      @Override
      public void onCompletion(boolean success, String error) {
        if (success) {
          if (result != null) {
            result.success(null);
          }
        }
        else {
          if (result != null) {
            result.success(error);
          }
        }
      }
    });
  }



  private static void updateUserName(String userName, final Result result) {
    WTLoginManager.UpdateUserProfileName(userName, new IWTCompletion() {
      @Override
      public void onCompletion(boolean success, String error) {
        if (success) {
          if (result != null) {
            result.success(null);
          }
        }
        else {
          if (result != null) {
            result.success(error);
          }
        }
      }
    });

  }


  private void sendLoginCallback(String error) {
    if (loginResult != null) {
      loginResult.success(error);
    }
    loginResult = null;
  }

  private void sendLogoutCallback(String error) {
    if (logoutResult != null) {
      logoutResult.success(error);
    }
    logoutResult = null;
  }

  private void sendP2POrderEvent(String userIdentifier, String storeID, String buyerOrderID, String sellerOrderID) {

    Map<String, Object> args = new HashMap<>();
    args.put(_cEventType, kWTEventTypeOrder);
    args.put(_cSuccess,true);
    args.put(_cError, null);
    args.put(_cStoreID, storeID);
    args.put(_cSellerOrderID, sellerOrderID);
    args.put(_cProductID, null);
    args.put(_cBuyerOrderID, buyerOrderID);
    args.put(_cWTUserIdentifier, userIdentifier);



    channel.invokeMethod(_cMethod, args);
  }

  private void sendP2PProductEvent(String userIdentifier, String storeID, String productID) {

    Map<String, Object> args = new HashMap<>();
    args.put(_cEventType, kWTEventTypeProduct);
    args.put(_cSuccess,true);
    args.put(_cError, null);
    args.put(_cStoreID, storeID);
    args.put(_cSellerOrderID, null);
    args.put(_cProductID, productID);
    args.put(_cBuyerOrderID, null);
    args.put(_cWTUserIdentifier, userIdentifier);

    channel.invokeMethod(_cMethod, args);
  }

  private void sendP2PStoreEvent(String userIdentifier, String storeID) {

    Map<String, Object> args = new HashMap<>();
    args.put(_cEventType, kWTEventTypeStore);
    args.put(_cSuccess,true);
    args.put(_cError, null);
    args.put(_cStoreID, storeID);
    args.put(_cSellerOrderID, null);
    args.put(_cProductID, null);
    args.put(_cBuyerOrderID, null);
    args.put(_cWTUserIdentifier, userIdentifier);

    channel.invokeMethod(_cMethod, args);
  }


  private void sendWannatalkEvent(int eventType, String error) {

    Map<String, Object> args = new HashMap<>();
    args.put(_cEventType, eventType);
    args.put(_cSuccess,error == null);
    args.put(_cError, error);


    channel.invokeMethod(_cMethod, args);
  }


//  WTChatLoader chatLoader = new WTChatLoader(new IWTChatLoader() {
//    @Override
//    public void showSpinner(boolean show) {
////                showProgressInd(show);
//    }
//
//    @Override
//    public void onCompletion(String error) {
////        Log.e(TAG, "onCompletion error:" + error);
//      if (error != null) {
//        String error_message = "Something went wrong. Please try again";
////          WTUIManager.ShowToastMessage(error_message);
//      }
//    }
//
//    @Override
//    public Activity getParentActivity() {
//      return activity;
//    }
//  });
//
//    chatLoader.loadUserChatPage(wtUserIdentifier, caption);

  IWTLoginManager iwtLoginManager = new IWTLoginManager() {

    @Override
    public void wtsdkUserLoggedIn() {
      sendLoginCallback(null);
      sendWannatalkEvent(kWTEventTypeLogin, null);
    }

    @Override
    public void wtsdkUserLoginFailed(String error) {
      sendLoginCallback(error);
      sendWannatalkEvent(kWTEventTypeLogin, error);
    }

    @Override
    public void wtsdkUserLoggedOut() {
      sendLogoutCallback(null);
      sendWannatalkEvent(kWTEventTypeLogout, null);
    }

    @Override
    public void wtsdkUserLogoutFailed(String error) {
      sendLogoutCallback(error);
      sendWannatalkEvent(kWTEventTypeLogout, error);
    }

  };


  IWTSDKCallbacks iwtsdkCallbacks = new IWTSDKCallbacks() {
    @Override
    public void topicBadgeCount(int badgeCount) {

    }

    @Override
    public void mochaBadgeCount(int badgeCount) {

    }

    @Override
    public void loadOrderPage(String userIdentifier, String storeID, String buyerID, String sellerID) {

      sendP2POrderEvent(userIdentifier, storeID, buyerID, sellerID);
//      WTUIManager.ShowToastMessage("loadOrderPage");
    }

    @Override
    public void loadProductPage(String userIdentifier, String storeID, String productID) {
      sendP2PProductEvent(userIdentifier, storeID, productID);
//      WTUIManager.ShowToastMessage("loadProductPage");
    }

    @Override
    public void loadStorePage(String userIdentifier, String storeID) {
//      WTUIManager.ShowToastMessage("loadStorePage");
      sendP2PStoreEvent(userIdentifier, storeID);
    }
  };

}
