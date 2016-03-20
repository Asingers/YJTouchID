
//  Created by Asingers on 16/3/20.
//  Copyright © 2016年 Asingers. All rights reserved.
//

#import "YJTouchID.h"

@interface YJTouchID ()

@end

@implementation YJTouchID 

- (void)startYJTouchIDWithMessage:(NSString *)message fallbackTitle:(NSString *)fallbackTitle delegate:(id<YJTouchIDDelegate>)delegate {
    
    LAContext *context = [[LAContext alloc]init];
    
    context.localizedFallbackTitle = fallbackTitle;
    
    NSError *error = nil;
    
    self.delegate = delegate;
    
    NSAssert(self.delegate != nil, YJNotice(@"YJTouchIDDelegate 不能为空", @"YJTouchIDDelegate must be non-nil"));
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:message == nil ? YJNotice(@"默认提示信息", @"The Default Message") : message reply:^(BOOL success, NSError * _Nullable error) { 
            
            if (success) {
                
                if ([self.delegate respondsToSelector:@selector(YJTouchIDAuthorizeSuccess)]) {
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.delegate YJTouchIDAuthorizeSuccess];
                    }];
                    
                }
            } else if (error) {
                
                switch (error.code) {
                        
                    case LAErrorAuthenticationFailed: {
                        
                        if ([self.delegate respondsToSelector:@selector(YJTouchIDAuthorizeFailure)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate YJTouchIDAuthorizeFailure];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorUserCancel: {
                        
                        if ([self.delegate respondsToSelector:@selector(YJTouchIDAuthorizeErrorUserCancel)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate YJTouchIDAuthorizeErrorUserCancel];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorUserFallback: {
                        
                        if ([self.delegate respondsToSelector:@selector(YJTouchIDAuthorizeErrorUserFallback)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate YJTouchIDAuthorizeErrorUserFallback];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorSystemCancel:{
                        
                        if ([self.delegate respondsToSelector:@selector(YJTouchIDAuthorizeErrorSystemCancel)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate YJTouchIDAuthorizeErrorSystemCancel];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDNotEnrolled: {
                        
                        if ([self.delegate respondsToSelector:@selector(YJTouchIDAuthorizeErrorTouchIDNotEnrolled)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate YJTouchIDAuthorizeErrorTouchIDNotEnrolled];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorPasscodeNotSet: {
                        
                        if ([self.delegate respondsToSelector:@selector(YJTouchIDAuthorizeErrorPasscodeNotSet)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate YJTouchIDAuthorizeErrorPasscodeNotSet];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDNotAvailable: {
                        
                        if ([self.delegate respondsToSelector:@selector(YJTouchIDAuthorizeErrorTouchIDNotAvailable)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate YJTouchIDAuthorizeErrorTouchIDNotAvailable];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorTouchIDLockout: {
                        
                        if ([self.delegate respondsToSelector:@selector(YJTouchIDAuthorizeErrorTouchIDLockout)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate YJTouchIDAuthorizeErrorTouchIDLockout];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorAppCancel:  {
                        
                        if ([self.delegate respondsToSelector:@selector(YJTouchIDAuthorizeErrorAppCancel)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate YJTouchIDAuthorizeErrorAppCancel];
                            }];
                        }
                    }
                        break;
                        
                    case LAErrorInvalidContext: {
                        
                        if ([self.delegate respondsToSelector:@selector(YJTouchIDAuthorizeErrorInvalidContext)]) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                [self.delegate YJTouchIDAuthorizeErrorInvalidContext];
                            }];
                        }
                    }
                        break;
                }
            }
        }];
        
    } else {
        
        if ([self.delegate respondsToSelector:@selector(YJTouchIDIsNotSupport)]) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.delegate YJTouchIDIsNotSupport];
            }];
        }
    }
}
 
@end
