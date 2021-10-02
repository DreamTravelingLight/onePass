//
//  CoustomView.h
//  buyer
//
//  Created by Jonson on 2020/1/14.
//  Copyright © 2020 Jonson
//

#import <UIKit/UIKit.h>
#import <React/RCTViewManager.h>
#import "RNSignWithAppleHelper.h"
#import "RNSignHandleKeyChain.h"

NS_ASSUME_NONNULL_BEGIN

@interface RNCoustomView : UIImageView

//@property(nonatomic,copy) NSString *imageUrl; //图片路径
//@property (nonatomic, copy)RCTBubblingEventBlock onClick;//点击事件
//+(instancetype)shareInstance;
+ (void)signInWithAppleWithSuccess:(void(^)(ASAuthorization *authorization,NSString *user,NSDictionary *userInfo))success
                           failure:(void (^)(NSError *err,NSString *errorMsg))failure;
- (void)handleAuthorizationAppleIDButtonPress;
@end

NS_ASSUME_NONNULL_END
