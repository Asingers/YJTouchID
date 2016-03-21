## 如何使用YJTouchID
* 将`YJTouchID`文件夹中的两个文件(`YJTouchID.h``YJTouchID.m`)拖入项目中
* 导入头文件：`#import "YJTouchID.h"`
```objc
/** 初始化 */
YJTouchID *touchid = [[YJTouchID alloc]init];

/** 发起TouchID验证 */
[touchid startYJTouchIDWithMessage:@"自定义信息" fallbackTitle:@"按钮标题" delegate:self];

/** 通过代理方法监听TouchID验证的所有结果 */

/** 其中的成功回调和失败回调是必须要实现的，其他的按实际情况各取所需 */
@required
- (void)YJTouchIDAuthorizeSuccess;
- (void)YJTouchIDAuthorizeFailure;

@optional
- (void)YJTouchIDIsNotSupport;
- (void)YJTouchIDAuthorizeErrorAppCancel;
- (void)YJTouchIDAuthorizeErrorUserCancel;
- (void)YJTouchIDAuthorizeErrorUserFallback;
- (void)YJTouchIDAuthorizeErrorSystemCancel;
- (void)YJTouchIDAuthorizeErrorPasscodeNotSet;
- (void)YJTouchIDAuthorizeErrorTouchIDLockout;
- (void)YJTouchIDAuthorizeErrorInvalidContext;
- (void)YJTouchIDAuthorizeErrorTouchIDNotEnrolled;
- (void)YJTouchIDAuthorizeErrorTouchIDNotAvailable;
```
