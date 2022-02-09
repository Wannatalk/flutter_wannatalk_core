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
  static final  String _cWTUserIdentifier= "userIdentifier";
  static final  String _cWTUserInfo= "userInfo";


  static final  int _kWTLoginMethod= 1001;
  static final  int _kWTSilentLoginMethod= 1002;
  static final  int _kWTLogoutMethod= 1003;
  static final  int _kWTOrgProfileMethod= 1004;
  static final  int _kWTChatListMethod= 1005;
  static final  int _kWTUserListMethod= 1006;
  static final  int _kWTUpdateUserNameMethod= 1007;
  static final  int _kWTUpdateUserImageMethod= 1008;
  static final  int _kWTIsUserLoggedIn= 1009;


  // OUT

  static final  String _cMethod= "wt_event";
  static final  String _cEventType= "eventType";
  static final  String _cSuccess= "success";
  static final  String _cError= "error";

  static final  int kWTEventTypeLogin= 2001;
  static final  int kWTEventTypeLogout= 2002;


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
        loadOrganizationProfile(autoOpenChat, result);
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

  void loadOrganizationProfile(Boolean autoOpenChat,final Result result) {
    // Load organization profile
    Activity currentActivity = getActivity();
    if (currentActivity != null) {
      WTSDKManager.LoadOrganizationActivity(currentActivity, autoOpenChat, new IWTCompletion() {
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

  private void sendWannatalkEvent(int eventType, String error) {

    Map<String, Object> args = new HashMap<>();
    args.put(_cEventType, eventType);
    args.put(_cSuccess,error == null);
    args.put(_cError, error);


    channel.invokeMethod(_cMethod, args);
  }


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
}
