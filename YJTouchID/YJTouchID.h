
//  Created by Asingers on 16/3/20.
//  Copyright © 2016年 Asingers. All rights reserved.
//
#import <LocalAuthentication/LocalAuthentication.h>
#if TARGET_IPHONE_SIMULATOR
#define YJNotice(Chinese,English) [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-US"] ? Chinese : English
#elif TARGET_OS_IPHONE
#define YJNotice(Chinese,English) [[[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0] isEqualToString:@"zh-Hans-CN"] ? Chinese : English
#endif

@class YJTouchID;

@protocol YJTouchIDDelegate <NSObject>

@required

/**
 *  TouchID验证成功
 *
 *  (English Comments) Authentication Successul
 */
- (void)YJTouchIDAuthorizeSuccess;

/** 
 *  TouchID验证失败
 *
 *  (English Comments) Authentication Failure
 */
- (void)YJTouchIDAuthorizeFailure;

@optional
/**
 *  取消TouchID验证 (用户点击了取消)
 *
 *  (English Comments) Authentication was canceled by user (e.g. tapped Cancel button).
 */
- (void)YJTouchIDAuthorizeErrorUserCancel;

/**
 *  在TouchID对话框中点击输入密码按钮
 *
 *  (English Comments) User tapped the fallback button
 */
- (void)YJTouchIDAuthorizeErrorUserFallback;

/** 
 *  在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏...
 *
 *  (English Comments) Authentication was canceled by system (e.g. another application went to foreground).
 */
- (void)YJTouchIDAuthorizeErrorSystemCancel;

/** 
 *  无法启用TouchID,设备没有设置密码
 *
 *  (English Comments) Authentication could not start, because passcode is not set on the device.
 */
- (void)YJTouchIDAuthorizeErrorPasscodeNotSet;

/**
 *  设备没有录入TouchID,无法启用TouchID
 *
 *  (English Comments) Authentication could not start, because Touch ID has no enrolled fingers
 */
- (void)YJTouchIDAuthorizeErrorTouchIDNotEnrolled;

/**
 *  该设备的TouchID无效
 *
 *  (English Comments) Authentication could not start, because Touch ID is not available on the device.
 */
- (void)YJTouchIDAuthorizeErrorTouchIDNotAvailable;

/** 
 *  多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
 *
 *  (English Comments) Authentication was not successful, because there were too many failed Touch ID attempts and Touch ID is now locked. Passcode is required to unlock Touch ID, e.g. evaluating LAPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite.
 *
 */
- (void)YJTouchIDAuthorizeErrorTouchIDLockout;

/**
 *  当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
 *
 *  (English Comments) Authentication was canceled by application (e.g. invalidate was called while authentication was inprogress).
 *
 */
- (void)YJTouchIDAuthorizeErrorAppCancel;

/** 
 *  当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
 *
 *  (English Comments) LAContext passed to this call has been previously invalidated.
 */
- (void)YJTouchIDAuthorizeErrorInvalidContext;

/**
 *  当前设备不支持指纹识别
 *
 *  (English Comments) The current device does not support fingerprint identification
 */
-(void)YJTouchIDIsNotSupport;

@end

@interface YJTouchID : LAContext

@property (nonatomic, weak) id<YJTouchIDDelegate> delegate;

/**
 *  发起TouchID验证 (Initiate TouchID validation)
 *
 *  @param message 提示框需要显示的信息 默认为：输入密码 (Fallback button title. Default is "Enter Password")
 */
- (void)startYJTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle delegate:(id<YJTouchIDDelegate>)delegate; 

@end