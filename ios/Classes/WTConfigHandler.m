//
//  WTConfigHandler.m
//  Wannatalkflutter
//
//  Created by Srikanth Ganji on 27/03/20.
//

#import "WTConfigHandler.h"
#import <WTExternalSDK/WTExternalSDK.h>


@implementation WTConfigHandler

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

#define cShow @"show"
#define cEnable @"enable"
#define cAllow @"allow"
#define cValue @"value"

#define cTimeoutInterval @"timeoutInterval"
#define cTimeInterval @"timeInterval"

+ (void) handleConfigMethodType:(NSInteger) methodType arguments:(NSDictionary *) args {

    switch (methodType) {
        case _kWTConfigClearTempFolder: {
            [self ClearTempFiles];
            break;
        }
        case _kWTConfigSetInactiveChatTimeout: {
            NSTimeInterval interval = [args[cTimeoutInterval] doubleValue];
            [self SetInactiveChatTimeoutInterval:interval];
            break;
        }
        case _kWTConfigSetAgentQueueInterval: {
            NSTimeInterval interval = [args[cTimeInterval] doubleValue];
            [self SetAgentQueueTimeInterval:interval];
            break;
        }
        case _kWTConfigShowGuideButton: {
            BOOL show = [args[cShow] boolValue];
            [self ShowGuideButton:show];
            break;
        }
        case _kWTConfigAllowSendAudioMessage: {
            BOOL allow = [args[cAllow] boolValue];
            [self AllowSendAudioMessage:allow];
            break;
        }
        case _kWTConfigAllowAddParticipant: {
            BOOL allow = [args[cAllow] boolValue];
            [self AllowAddParticipants:allow];
            break;
        }
        case _kWTConfigAllowRemoveParticipants: {
            BOOL allow = [args[cAllow] boolValue];
            [self AllowRemoveParticipants:allow];
            break;
        }
        case _kWTConfigShowWelcomePage: {
            BOOL show = [args[cShow] boolValue];
            [self ShowWelcomeMessage:show];
            break;
        }
        case _kWTConfigShowProfileInfoPage: {
            BOOL show = [args[cShow] boolValue];
            [self ShowProfileInfoPage:show];
            break;
        }
        case _kWTConfigEnableAutoTickets: {
            BOOL enable = [args[cEnable] boolValue];
            [self EnableAutoTickets:enable];
            break;
        }
        case _kWTConfigShowExitButton: {
            BOOL show = [args[cShow] boolValue];
            [self ShowExitButton:show];
            break;
        }
        case _kWTConfigShowChatParticipants: {
            BOOL show = [args[cShow] boolValue];
            [self ShowChatParticipants:show];
            break;
        }
        case _kWTConfigEnableChatProfile: {
            BOOL enable = [args[cEnable] boolValue];
            [self EnableChatProfile:enable];
            break;
        }
        case _kWTConfigAllowModifyChatProfile: {
            BOOL allow = [args[cAllow] boolValue];
            [self AllowModifyChatProfile:allow];
            break;
        }
        case _kWTConfigShowHomeButton: {
            BOOL value = [args[cValue] boolValue];
            [self ShowHomeButton:value];
            break;
        }
        case _kWTConfigSetChatBGColor: {
            NSString *value = args[cValue];
            [self SetChatBGColor:value];
            break;
        }
        case _kWTConfigSetChatHeaderColor: {
            NSString *value = args[cValue];
            [self SetChatHeaderColor:value];
            break;
        }
        case _kWTConfigSetChatTitleColor: {
            NSString *value = args[cValue];
            [self SetChatTitleColor:value];
            break;
        }
        case _kWTConfigSetFontNames: {
            NSString *regular = args[@"regular"];
            NSString *bold = args[@"bold"];
            NSString *italic = args[@"italic"];
            NSString *medium = args[@"medium"];
            NSString *light = args[@"light"];
            
            NSMutableDictionary *dctFonts = [NSMutableDictionary new];
            dctFonts[@"regular"] = regular;
            dctFonts[@"bold"] = bold;
            dctFonts[@"italic"] = italic;
            dctFonts[@"medium"] = medium;
            dctFonts[@"light"] = light;
            
            [self SetFontNames:dctFonts];
            break;
        }

        default: {

            break;
        }

    }

}


+ (void)ClearTempFiles {
    [WTSDKManager ClearTempDirectory];
}

// To show or hide guide button
+ (void)ShowGuideButton:(BOOL) show               // default = YES
{
    [WTSDKManager ShowGuideButton:show];
}

// To enable or disable sending audio message
+ (void)AllowSendAudioMessage:(BOOL) allow  // default = YES
{
    [WTSDKManager ShouldAllowSendAudioMessage:allow];
}

// To show or hide add participants option in new ticket page and chat item profile page
+ (void)AllowAddParticipants:(BOOL) allow    // default = YES
{
    [WTSDKManager ShouldAllowAddParticipant:allow];
}

// To show or hide remove participants option in chat item profile
+ (void)AllowRemoveParticipants:(BOOL) allow // default = NO
{
    [WTSDKManager ShouldAllowRemoveParticipant:allow];
}

// To show or hide welcome message
+ (void)ShowWelcomeMessage:(BOOL) show            // default = NO
{
    [WTSDKManager ShowWelcomeMessage:show];
}

// To show or hide Profile Info page
+ (void)ShowProfileInfoPage:(BOOL) show           // default = YES
{
    [WTSDKManager ShowProfileInfoPage:show];
}

// To create auto tickets:
//Chat ticket will create automatically when auto tickets is enabled, otherwise default ticket creation page will popup
+ (void)EnableAutoTickets:(BOOL) enable           // default = NO
{
    [WTSDKManager EnableAutoTickets:enable];
}

// To show or hide close chat button in chat page
+ (void)ShowExitButton:(BOOL) show                // default = NO
{
    [WTSDKManager ShowExitButton:show];
}

// To show or hide participants in chat profile page
+ (void)ShowChatParticipants:(BOOL) show          // default = YES
{
    [WTSDKManager ShowChatParticipants:show];
}

// To enable or disbale chat profile page
+ (void)EnableChatProfile:(BOOL) enable           // default = YES
{
    [WTSDKManager EnableChatProfile:enable];
}

// To allow modify  in chat profile page
+ (void)AllowModifyChatProfile:(BOOL) allow       // default = YES
{
    [WTSDKManager AllowModifyChatProfile:allow];
}

// To set Inactive chat timeout:
//Chat session will end if user is inactive for timeout interval duration. If timeout interval is 0, chat session will not end automatically. The default timout interval is 1800 seconds (30 minutes).
+ (void)SetInactiveChatTimeoutInterval:(double) timeoutInterval   // default = 1800 seconds (30 minutes).
{
    [WTSDKManager SetInactiveChatTimeoutInterval:timeoutInterval];
}

// To set timeinterval for checking the available agent // default 20 seconds
+ (void) SetAgentQueueTimeInterval:(double) timeInterval {
    [WTSDKManager SetAgentQueueTimeInterval:timeInterval];
}

+ (void) ShowHomeButton:(BOOL) value {
    [WTSDKManager ShowHomeButton:value];
}

+ (void) SetChatHeaderColor:(NSString *) value {
    [WTSDKManager SetChatHeaderColor: value];
}

+ (void) SetChatTitleColor:(NSString *) value {
    [WTSDKManager SetChatTitleColor: value];
}

+ (void) SetChatBGColor:(NSString *) value {
    [WTSDKManager SetChatBGColor: value];
}

+ (void) SetFontNames:(NSDictionary *) value {
    [WTSDKManager SetFontNames: value];
}

@end
