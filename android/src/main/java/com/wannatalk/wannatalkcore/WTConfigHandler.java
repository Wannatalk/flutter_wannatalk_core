package com.wannatalk.wannatalkcore;


import androidx.annotation.NonNull;

import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.MethodChannel;
import wannatalk.wannatalksdk.WTCore.WTSDKManager;

public class WTConfigHandler {
    static final int _kWTConfigClearTempFolder = 9001;
    static final int _kWTConfigSetInactiveChatTimeout = 9002;
    static final int _kWTConfigShowGuideButton = 9003;
    static final int _kWTConfigAllowSendAudioMessage = 9004;
    static final int _kWTConfigAllowAddParticipant = 9005;
    static final int _kWTConfigAllowRemoveParticipants = 9006;
    static final int _kWTConfigShowWelcomePage = 9007;
    static final int _kWTConfigShowProfileInfoPage = 9008;
    static final int _kWTConfigEnableAutoTickets = 9009;
    static final int _kWTConfigShowExitButton = 9010;
    static final int _kWTConfigShowChatParticipants = 9011;
    static final int _kWTConfigEnableChatProfile = 9012;
    static final int _kWTConfigAllowModifyChatProfile = 9013;
    static final int _kWTConfigSetAgentQueueInterval = 9014;

    static final  int _kWTConfigShowHomeButton= 9015;
    static final  int _kWTConfigSetChatHeaderColor= 9016;
    static final  int _kWTConfigSetChatTitleColor= 9017;
    static final  int _kWTConfigSetChatBGColor= 9018;
    static final  int _kWTConfigSetFontNames= 9019;

    static final String _cShow = "show";
    static final String _cEnable = "enable";
    static final String _cAllow = "allow";
    static final String _cValue = "value";
    static final String _cTimeoutInterval = "timeoutInterval";
    static final  String _cTimeInterval = "timeInterval";

    public static void HandleMethodType(int methodType, Map<String, Object> args, @NonNull MethodChannel.Result result) {

        switch (methodType) {
            case _kWTConfigClearTempFolder: {
                ClearTempFiles();
                break;
            }
            case _kWTConfigSetInactiveChatTimeout: {
                long interval = (long) args.get(_cTimeoutInterval);
                SetInactiveChatTimeoutInterval(interval);
                break;
            }
            case _kWTConfigSetAgentQueueInterval: {
                long interval = (long) args.get(_cTimeInterval);
                SetAgentQueueInterval(interval);
                break;
            }
            case _kWTConfigShowGuideButton: {
                boolean show = (boolean) args.get(_cShow);
                ShowGuideButton(show);
                break;
            }
            case _kWTConfigAllowSendAudioMessage: {
                boolean allow = (boolean) args.get(_cAllow);
                AllowSendAudioMessage(allow);
                break;
            }
            case _kWTConfigAllowAddParticipant: {
                boolean allow = (boolean) args.get(_cAllow);
                AllowAddParticipants(allow);
                break;
            }
            case _kWTConfigAllowRemoveParticipants: {
                boolean allow = (boolean) args.get(_cAllow);
                AllowRemoveParticipants(allow);
                break;
            }
            case _kWTConfigShowWelcomePage: {
                boolean show = (boolean) args.get(_cShow);
                ShowWelcomeMessage(show);
                break;
            }
            case _kWTConfigShowProfileInfoPage: {
                boolean show = (boolean) args.get(_cShow);
                ShowProfileInfoPage(show);
                break;
            }
            case _kWTConfigEnableAutoTickets: {
                boolean enable = (boolean) args.get(_cEnable);
                EnableAutoTickets(enable);
                break;
            }
            case _kWTConfigShowExitButton: {
                boolean show = (boolean) args.get(_cShow);
                ShowExitButton(show);
                break;
            }
            case _kWTConfigShowChatParticipants: {
                boolean show = (boolean) args.get(_cShow);
                ShowChatParticipants(show);
                break;
            }
            case _kWTConfigEnableChatProfile: {
                boolean enable = (boolean) args.get(_cEnable);
                EnableChatProfile(enable);
                break;
            }
            case _kWTConfigAllowModifyChatProfile: {
                boolean allow = (boolean) args.get(_cAllow);
                AllowModifyChatProfile(allow);
                break;
            }
            case _kWTConfigShowHomeButton: {
                boolean value = (boolean) args.get(_cValue);
                ShowHomeButton(value);
                break;
            }
            case _kWTConfigSetChatBGColor: {
                String value = (String) args.get(_cValue);
                SetChatBGColor(value);
                break;
            }
            case _kWTConfigSetChatHeaderColor: {
                String value = (String) args.get(_cValue);
                SetChatHeaderColor(value);
                break;
            }
            case _kWTConfigSetChatTitleColor: {
                String value = (String) args.get(_cValue);
                SetChatTitleColor(value);
                break;
            }
            case _kWTConfigSetFontNames: {
                String fRegular = (String) args.get("regular");
                String fBold = (String) args.get("bold");
                String fLight = (String) args.get("light");
                String fItalic = (String) args.get("italic");
                String fMedium = (String) args.get("medium");


                HashMap<String, String> fontNames = new HashMap<String, String>();
                fontNames.put("regular", fRegular);
                fontNames.put("bold", fBold);
                fontNames.put("light", fLight);
                fontNames.put("medium", fMedium);
                fontNames.put("italic", fItalic);

                SetFontNames(fontNames);
                break;
            }

            default: {
                result.notImplemented();
                break;
            }

        }
    }

//    private static void ClearOldTempFiles() {
//        WTSDKManager.ClearOldTempFiles();
//    }


    private static void ClearTempFiles() {
        WTSDKManager.ClearOldTempFiles();
        WTSDKManager.ClearTempFiles();
    }


    private static void ShowGuideButton(boolean show) {
        WTSDKManager.ShowGuideButton(show);
    }


    private static void ShowProfileInfoPage(boolean show) {
        WTSDKManager.ShowProfileInfoPage(show);
    }


    private static void AllowSendAudioMessage(boolean allow) {
        WTSDKManager.AllowSendAudioMessage(allow);
    }


    private static void AllowAddParticipants(boolean allow) {
        WTSDKManager.AllowAddParticipants(allow);
    }


    private static void AllowRemoveParticipants(boolean allow) {
        WTSDKManager.AllowRemoveParticipants(allow);
    }


    private static void ShowWelcomeMessage(boolean show) {
        WTSDKManager.ShowWelcomeMessage(show);
    }


    private static void EnableAutoTickets(boolean enable) {
        WTSDKManager.EnableAutoTickets(enable);
    }


    private static void ShowExitButton(boolean show) {
        WTSDKManager.ShowExitButton(show);
    }


    private static void ShowChatParticipants(boolean show) {
        WTSDKManager.ShowChatParticipants(show);
    }


    private static void EnableChatProfile(boolean enable) {
        WTSDKManager.EnableChatProfile(enable);
    }


    private static void AllowModifyChatProfile(boolean allow) {
        WTSDKManager.AllowModifyChatProfile(allow);
    }


    private static void SetInactiveChatTimeoutInterval(long timeoutInSeconds) {
        WTSDKManager.SetInactiveChatTimeoutInterval(timeoutInSeconds);
    }

    private static void SetAgentQueueInterval(long timeIntervalInSeconds) {
        WTSDKManager.SetAgentQueueInterval(timeIntervalInSeconds);
    }


    private static void ShowHomeButton(boolean show) {
        WTSDKManager.ShowHomeButton(show);
    }


    private static void SetExitButtonName(String value) {
        WTSDKManager.SetExitButtonName(value);
    }


    private static void SetChatBGColor(String value) {
        WTSDKManager.SetChatBGColor(value);
    }

    private static void SetChatHeaderColor(String value) {
        WTSDKManager.SetChatHeaderColor(value);
    }

    private static void SetChatTitleColor(String value) {
        WTSDKManager.SetChatTitleColor(value);
    }

    private static void SetFontNames(HashMap<String, String> fontNames) {
        WTSDKManager.SetFontNames(fontNames);
    }

}
