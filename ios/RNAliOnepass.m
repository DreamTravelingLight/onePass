
#import "RNAliOnepass.h"
#import "RNSignWithApple.h"
#import "RNCoustomView.h"
#import "UIButton+category.h"
#import "PNSBuildModelUtils.h"

#define TX_SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define TX_SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define IS_HORIZONTAL (TX_SCREEN_WIDTH > TX_SCREEN_WIDTH)

#define TX_Alert_NAV_BAR_HEIGHT      55.0
#define TX_Alert_HORIZONTAL_NAV_BAR_HEIGHT      41.0

//竖屏弹窗
#define TX_Alert_Default_Left_Padding         42
#define TX_Alert_Default_Top_Padding          115

/**横屏弹窗*/
#define TX_Alert_Horizontal_Default_Left_Padding      80.0


@implementation RNAliOnepass {
    TXCommonHandler *tXCommonHandler;
    NSInteger *prefetchNumberTimeout;
    TXCustomModel *tXCustomModel;
    
    BOOL checkBox;
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(init:(NSString *)secretInfo resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject) {
    tXCommonHandler = [TXCommonHandler sharedInstance];
    [tXCommonHandler setAuthSDKInfo:secretInfo complete:^(NSDictionary * _Nonnull resultDic) {
        NSString *resultCode = [resultDic objectForKey:@"resultCode"];
        if(resultCode==PNSCodeSuccess) {
            resolve(@"");
        } else {
            reject(resultCode, [resultDic objectForKey:@"msg"], nil);
        }
    }];
}

// 判断是否初始化过
-(BOOL)checkInit:(RCTPromiseRejectBlock)reject {
    if(tXCommonHandler == nil) {
        reject(@"0", @"请先调用初始化接口init", nil);
        return false;
    }
    return true;
}


// 检查认证环境 第一次或者切换网络后需要重新调用
RCT_EXPORT_METHOD(checkEnvAvailable:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject){
    if(![self checkInit:reject]){
        reject(@"bnqInitError", @"checkInit初始化失败，不满足一键登录条件", nil);
        return;
    }
    [tXCommonHandler checkEnvAvailableWithComplete:^(NSDictionary * _Nullable resultDic) {
        NSString *resultCode = [resultDic objectForKey:@"resultCode"];
        if(resultCode==PNSCodeSuccess) {
            resolve(@"");
        } else {
            reject(resultCode, [resultDic objectForKey:@"msg"], nil);
        }
    }];
}

// 预取号 加速页面弹起
RCT_EXPORT_METHOD(prefetch:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject){
    if(![self checkInit:reject]){
        return;
    }
    [tXCommonHandler accelerateLoginPageWithTimeout:0.0 complete:^(NSDictionary * _Nonnull resultDic) {
        NSString *resultCode = [resultDic objectForKey:@"resultCode"];
        if(resultCode==PNSCodeSuccess) {
            resolve(@"");
        } else {
            reject(resultCode, [resultDic objectForKey:@"msg"], nil);
        }
    }];
}

// 一键登录 页面弹起
RCT_EXPORT_METHOD(onePass:(NSDictionary *)config showType:(NSUInteger)type resolve:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject){
    __weak typeof(self) weakSelf = self;
        tXCustomModel = [PNSBuildModelUtils buildModelWithStyle:type config:config target:self block:^(UIButton * _Nonnull btn) {
            [btn addTarget:weakSelf action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }];
    
    if(![self checkInit:reject]){
        [self sendEventWithName:@"onTokenFailed" body:@{
                                                        @"msg": @"页面弹起失败",
                                                        @"code": @"bnq100",
                                           }];
        return;
    }
    [[TXCommonHandler sharedInstance] getLoginTokenWithTimeout:0.0
                                                    controller:[UIApplication sharedApplication].keyWindow.rootViewController
                                                         model:tXCustomModel
                                                      complete:^(NSDictionary * _Nonnull resultDic) {
        NSString *resultCode = [NSString stringWithFormat:@"%@",[resultDic objectForKey:@"resultCode"]];
                NSString *msg = [resultDic objectForKey:@"msg"];
                NSString *token = [resultDic objectForKey:@"token"];
        NSNumber *checkStatus = [resultDic objectForKey:@"isChecked"];
        self->checkBox = [checkStatus boolValue];
        if ([PNSCodeLoginControllerPresentSuccess isEqualToString:resultCode]) {
            NSLog(@"授权页拉起成功回调：%@", resultDic);
            [self sendEventWithName:@"pageDrawSuccess" body:@{
                                                                     @"msg": msg!=nil ? msg: @"",
                                                                     @"code": resultCode!=nil?resultCode:@"",
                                                       @"token": token!=nil ? token : @"",
                                                                     @"showType":[NSString stringWithFormat:@"%lu",(unsigned long)type]
                                                       }];
        } else if ([PNSCodeLoginControllerClickCancel isEqualToString:resultCode] ||
                   [PNSCodeLoginControllerClickChangeBtn isEqualToString:resultCode] ||
                   [PNSCodeLoginControllerClickLoginBtn isEqualToString:resultCode] ||
                   [PNSCodeLoginControllerClickCheckBoxBtn isEqualToString:resultCode] ||
                   [PNSCodeLoginControllerClickProtocol isEqualToString:resultCode]) {
            NSLog(@"页面点击事件回调：%@", resultDic);
                
            
            if ([PNSCodeLoginControllerClickChangeBtn isEqualToString:resultCode]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self sendEventWithName:@"pageClickEvents" body:@{
                                                                             @"msg": msg!=nil ? msg: @"",
                                                                             @"code": resultCode!=nil?resultCode:@"",
                                                               @"token": token!=nil ? token : @"",
                                                                             @"showType":[NSString stringWithFormat:@"%lu",(unsigned long)type]
                                                               }];
                    [[TXCommonHandler sharedInstance] cancelLoginVCAnimated:NO complete:nil];
                });
            }else{
                [self sendEventWithName:@"pageClickEvents" body:@{
                                                                         @"msg": msg!=nil ? msg: @"",
                                                                         @"code": resultCode!=nil?resultCode:@"",
                                                           @"token": token!=nil ? token : @"",
                                                                         @"showType":[NSString stringWithFormat:@"%lu",(unsigned long)type]
    //                                                                     @"isCheck":checkStatus
                                                           }];
            }
            
        } else if ([PNSCodeSuccess isEqualToString:resultCode]) {
            NSLog(@"获取LoginToken成功回调：%@", resultDic);
            NSLog(@"接下来可以拿着Token去服务端换取手机号，有了手机号就可以登录，SDK提供服务到此结束");
            [[TXCommonHandler sharedInstance] cancelLoginVCAnimated:YES complete:nil];
            [self sendEventWithName:@"onTokenSuccess" body:@{
                                                                     @"msg": msg!=nil ? msg: @"",
                                                                     @"code": resultCode!=nil?resultCode:@"",
                                                       @"token": token!=nil ? token : @"",
                                                                     @"showType":[NSString stringWithFormat:@"%lu",(unsigned long)type]
                                                       }];
        } else {
            NSLog(@"获取LoginToken或拉起授权页失败回调：%@", resultDic);
                        [self sendEventWithName:@"onTokenFailed" body:@{
                                                                        @"msg": msg!=nil ? msg: @"",
                                                                        @"code": resultCode!=nil?resultCode:@"",
                                                                        @"showType":[NSString stringWithFormat:@"%lu",(unsigned long)type]
                                                           }];
        }
    }];
    resolve(@"");
}

// 退出登录授权
RCT_EXPORT_METHOD(quitLoginPage:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject){
    [tXCommonHandler cancelLoginVCAnimated:true complete:^{
        resolve(@"");
    }];
}

// 授权⻚的 loading
RCT_EXPORT_METHOD(hideLoginLoading:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject){
    [tXCommonHandler hideLoginLoading];
    resolve(@"");
}

// 运行商类型 中国移动/中国联通/中国电信
RCT_EXPORT_METHOD(getOperatorType:(RCTPromiseResolveBlock)resolve reject:(RCTPromiseRejectBlock)reject){
    NSString *type = [TXCommonUtils getCurrentCarrierName];
    resolve(type);
}

// 将方法名转为key名 主要是和安卓端的逻辑保持一致
-(NSString *)methodName2KeyName:(NSString *)methodName {
    NSString *result = @"";
    if(methodName == nil) {
        return result;
    }
    if ([methodName hasPrefix:@"set"]) {
        result = [methodName substringFromIndex:3];
    }
    NSString *firstChar = [result substringWithRange:NSMakeRange(0, 1)];
    NSString *otherChar = [result substringFromIndex:1];
    return [[firstChar lowercaseString] stringByAppendingString:otherChar];
}

- (void)btnClick: (UIGestureRecognizer *) sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[TXCommonHandler sharedInstance] cancelLoginVCAnimated:YES complete:nil];
    });
}

-(void)bottomBtnClick:(UIButton *) sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"sender%@",sender);
        if (!self->checkBox) {
            [self sendEventWithName:@"showToast"
                                       body:@{@"msg":@"请先阅读并同意相关协议"}];
            return;
        }
        if ([sender.btnImageName  isEqual: @"icon_apple"]) {
            [self loginApple];
        }else{
            [self sendEventWithName:@"otherLoginTypeSelect"
                                       body:@{@"key":@"otherLogin",@"loginType":sender.btnImageName}];
        }
    });
}

-(void)loginApple{
    [RNCoustomView signInWithAppleWithSuccess:^(ASAuthorization * _Nonnull authorization, NSString * _Nonnull user, NSDictionary * _Nonnull userInfo) {
        [self sendEventWithName:@"appleLoginResult"
                                   body:@{@"key":@"success",@"userInfo":userInfo}];
    } failure:^(NSError * _Nonnull err, NSString * _Nonnull errorMsg) {
        [self sendEventWithName:@"appleLoginResult"
                                   body:@{@"key":@"fail",@"errorMsg":errorMsg}];
    }];
}


/**
 onTokenSuccess 获取token成功回调
 pageClickEvents 页面点击事件回调
 pageDrawSuccess 页面成功拉起回调
 onTokenFailed 获取token失败回调
 otherLoginTypeSelect 其他登录方式回调
 appleLoginResult 苹果登录结果
 showToast 显示提示文案
 */
-(NSArray<NSString *> *)supportedEvents {
    return @[@"onTokenSuccess",@"pageClickEvents",@"pageDrawSuccess", @"onTokenFailed",@"otherLoginTypeSelect",@"appleLoginResult",@"showToast"];
}

- (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

/// 是否是横屏 YES:横屏 NO:竖屏
- (BOOL)isHorizontal:(CGSize)size {
    return size.width > size.height;
}

@end

