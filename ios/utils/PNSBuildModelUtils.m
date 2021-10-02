//
//  PNSBuildModelUtils.m
//  ATAuthSceneDemo
//
//  Created by 刘超的MacBook on 2020/8/6.
//  Copyright © 2020 刘超的MacBook. All rights reserved.
//

#import "PNSBuildModelUtils.h"
#import "UIButton+category.h"

@implementation PNSBuildModelUtils

#pragma marl - 官方demo示例
+ (TXCustomModel *)buildModelWithStyle:(PNSBuildModelStyle)style
                          button1Title:(NSString *)button1Title
                               target1:(id)target1
                             selector1:(SEL)selector1
                          button2Title:(NSString *)button2Title
                               target2:(id)target2
                             selector2:(SEL)selector2 {
    TXCustomModel *model = nil;
    switch (style) {
        
        case PNSBuildModelStylePortrait:
            model = [self buildFullScreenPortraitModelWithButton1Title:button1Title
                                                               target1:target1
                                                             selector1:selector1
                                                          button2Title:button2Title
                                                               target2:target2
                                                             selector2:selector2];
            break;
        case PNSBuildModelStyleLandscape:
            model = [self buildFullScreenLandscapeModelWithButton1Title:button1Title
                                                                target1:target1
                                                              selector1:selector1
                                                           button2Title:button2Title
                                                                target2:target2
                                                              selector2:selector2];
            break;
        case PNSBuildModelStyleAutorotate:
            model = [self buildFullScreenAutorotateModelWithButton1Title:button1Title
                                                                 target1:target1
                                                               selector1:selector1
                                                            button2Title:button2Title
                                                                 target2:target2
                                                               selector2:selector2];
            break;
        case PNSBuildModelStyleAlertPortrait:
            model = [self buildAlertPortraitModeWithButton1Title:button1Title
                                                         target1:target1
                                                       selector1:selector1
                                                    button2Title:button2Title
                                                         target2:target2
                                                       selector2:selector2];
            break;
        case PNSBuildModelStyleAlertLandscape:
            model = [self buildAlertLandscapeModeWithButton1Title:button1Title
                                                          target1:target1
                                                        selector1:selector1
                                                     button2Title:button2Title
                                                          target2:target2
                                                        selector2:selector2];
            break;
        case PNSBuildModelStyleAlertAutorotate:
            model = [self buildAlertAutorotateModeWithButton1Title:button1Title
                                                           target1:target1
                                                         selector1:selector1
                                                      button2Title:button2Title
                                                           target2:target2
                                                         selector2:selector2];
            break;
        case PNSBuildModelStyleSheetPortrait:
            model = [self buildSheetPortraitModelWithButton1Title:button1Title
                                                          target1:target1
                                                        selector1:selector1
                                                     button2Title:button2Title
                                                          target2:target2
                                                        selector2:selector2];
            break;
        
        
        default:
            break;
    }
    return model;
}

#pragma mark - 百安居
+ (TXCustomModel *)buildModelWithStyle:(PNSBuildModelStyle)style
                                config:(NSDictionary *)config
                                target:(id)target
                                 block:(void (^)(UIButton *btn))block{
    TXCustomModel *model = nil;
    switch (style) {
        case PNSBuilsModalStyleCustomOfBnq:
            model = [self buildCustomBnqModelWithStyle:style config:config target:target block:block];
            break;
        case PNSBuildModelStyleSheetPortraitOfBnq:
            model = [self buildSheetPortraitModelWithStyle:style config:config target:target block:block];
            break;
        default:
            break;
    }
    return  model;
}
+ (TXCustomModel *)buildCustomBnqModelWithStyle:(PNSBuildModelStyle)style
                                config:(NSDictionary *)config
                                target:(id)target
                                block:(void (^)(UIButton *btn))block{
    // 状态栏
//    PNSBuildModelUtils *util = [[PNSBuildModelUtils alloc] init];
    TXCustomModel *tXCustomModel = [[TXCustomModel alloc] init];
    NSString *statusBarHidden = [config objectForKey:[self methodName2KeyName:@"setStatusBarHidden"]];
    if (statusBarHidden != nil) {
        tXCustomModel.prefersStatusBarHidden = [statusBarHidden boolValue];
    }
    // 标题栏
    NSString *navColor = [config objectForKey:[self methodName2KeyName:@"setNavColor"]];
    if (navColor != nil) {
        tXCustomModel.navColor = [self colorWithHexString:navColor];
    }
    NSString *navText = [config objectForKey:[self methodName2KeyName:@"setNavText"]];
    NSString *navTextColor = [config objectForKey:[self methodName2KeyName:@"setNavTextColor"]];
    NSString *navTextSize = [config objectForKey:[self methodName2KeyName:@"setNavTextSize"]];
    if (navText != nil && navTextColor != nil && navTextSize != nil) {
        tXCustomModel.navTitle = [[NSAttributedString alloc]initWithString:navText attributes:@{NSForegroundColorAttributeName: [self colorWithHexString:navTextColor], NSFontAttributeName:[UIFont systemFontOfSize:[navTextSize doubleValue]]}];
    }
    NSString *navReturnImgPath = [config objectForKey:[self methodName2KeyName:@"setNavReturnImgPath"]];
    if (navReturnImgPath != nil) {
        tXCustomModel.navBackImage = [UIImage imageNamed:navReturnImgPath];
        tXCustomModel.privacyNavBackImage = [UIImage imageNamed:navReturnImgPath];
    }
    NSString *navReturnImgWidth = [config objectForKey:[self methodName2KeyName:@"setNavReturnImgWidth"]];
    NSString *navReturnImgHeight = [config objectForKey:[self methodName2KeyName:@"setNavReturnImgHeight"]];
    __weak typeof(self) weakSelf = self;
    tXCustomModel.navBackButtonFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        NSString *navReturnOffsetX = [config objectForKey:[weakSelf methodName2KeyName:@"setNavReturnOffsetX"]];
        CGFloat x = frame.origin.x;
        if (navReturnOffsetX != nil) {
            x =[navReturnOffsetX floatValue];
        }
        NSString *navReturnOffsetY = [config objectForKey:[weakSelf methodName2KeyName:@"setNavReturnOffsetY"]] ;
        CGFloat y = frame.origin.y;
        if (navReturnOffsetY !=nil) {
            y = [navReturnOffsetY floatValue];
        }
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        if (navReturnImgWidth != nil) {
            width = [navReturnImgWidth floatValue];
        }
        if (navReturnImgHeight != nil) {
            height = [navReturnImgHeight floatValue];
        }
        return CGRectMake(x, y, width, height);
    };
    // logo
    [self setLogoViewWithModal:tXCustomModel config:config];
    // number
    [self setPhoneNumberViewWithModel:tXCustomModel config:config];
    // slogan
    [self setSloganViewWithModel:tXCustomModel config:config];
    // logBtn
    [self setLoginBtnViewWithModel:tXCustomModel config:config];
    // switch
    [self setSwitchViewWithModel:tXCustomModel config:config];
    // orivacy
    [self setOrivacyViewWithModel:tXCustomModel config:config];
    
    //添加自定义控件并对自定义控件进行布局
    NSString *customState = [config objectForKey:[self methodName2KeyName:@"setCustomState"]];
    if (customState != nil) {
//        展示自定义控件
        CGFloat mainWidth =[UIScreen mainScreen].bounds.size.width-48*2;
        UIView *customView = [[UIView alloc] init];
        CGFloat customViewHeight = 0;
//        自定义标题
        NSString *customtitle = [config objectForKey:[self methodName2KeyName:@"setCustomTitle"]];
        UIView *customTopView;
        if(customtitle != nil){
            customTopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mainWidth, 20)];
            [customView addSubview:customTopView];
            
            CGFloat textWidth = [customtitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}].width;
            NSLog(@"customtitle:%@   \n textWidth:%f",customtitle,textWidth);
            UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 8.5, (mainWidth - textWidth-16) * 0.5, 1)];
            leftView.backgroundColor = [self colorWithHexString:@"#eeeeee"];
            [customTopView addSubview:leftView];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftView.frame), 0, textWidth+16, 16)];
            label.text = [NSString stringWithFormat:@"%@", customtitle];
            label.textColor = [self colorWithHexString:@"#666666"];
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentCenter;
            [customTopView addSubview:label];
            
            UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 8.5, (mainWidth - textWidth-16) * 0.5, 1)];
            rightView.backgroundColor = [self colorWithHexString:@"#eeeeee"];
            [customTopView addSubview:rightView];
            
            customViewHeight = 20;
        }
        
        NSArray *customImages = [config objectForKey:[self methodName2KeyName:@"setCustomImagesPath"]];
        if (customImages != nil && [customImages isKindOfClass:[NSArray class]]) {
            
            CGFloat customImgWidth = [[config objectForKey:[self methodName2KeyName:@"setCustomImagesWidth"]] floatValue];
            CGFloat customImgHeight = [[config objectForKey:[self methodName2KeyName:@"setCustomImagesHeight"]] floatValue];
//            按钮间隙
            CGFloat customImgSpace = [[config objectForKey:[self methodName2KeyName:@"setCustomImagesSpace"]] floatValue];
            
            UIView *btnBgView = [[UIView alloc] init];
            CGFloat btnBgViewWidth = customImages.count*customImgWidth +customImgSpace*(customImages.count-1);
            btnBgView.frame  =CGRectMake((mainWidth-btnBgViewWidth)/2, CGRectGetMaxY(customTopView.frame)+13, btnBgViewWidth, customImgHeight);
            [customView addSubview:btnBgView];
            customViewHeight += 13 + customImgHeight;
//            自定义底部按钮
            for(int i = 0 ; i<customImages.count; i++){
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(i*(customImgSpace+customImgWidth), 5, customImgWidth, customImgHeight);
                    [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",customImages[i]]] forState:UIControlStateNormal];
                btn.btnImageName = customImages[i];
                block(btn);
                    [btnBgView addSubview:btn];
            }
            
        }
        
        customView.frame = CGRectMake(0, 0, mainWidth, customViewHeight);
        tXCustomModel.customViewBlock = ^(UIView * _Nonnull superCustomView) {
             [superCustomView addSubview:customView];
        };
        
        tXCustomModel.customViewLayoutBlock = ^(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
            CGRect frame = customView.frame;
            frame.origin.x = (contentViewFrame.size.width - frame.size.width) * 0.5;
            frame.origin.y = CGRectGetMinY(privacyFrame) - frame.size.height - 24;
//            frame.origin.y = 20;
            frame.size.width = contentViewFrame.size.width - frame.origin.x * 2;
            customView.frame = frame;
        };
    }
    return tXCustomModel ;
}

#pragma mark - 百安居---底部弹窗
+ (TXCustomModel *)buildSheetPortraitModelWithStyle:(PNSBuildModelStyle)style
                                           config:(NSDictionary *)config
                                           target:(id)target
                                           block:(void (^)(UIButton *btn))block {
    TXCustomModel *model = [[TXCustomModel alloc] init];
    model.alertCornerRadiusArray = @[@10, @0, @0, @10];
    model.alertTitleBarColor = [UIColor whiteColor];
    NSString *alertTitle = [config objectForKey:[self methodName2KeyName:@"setAlertTitle"]];
    if (alertTitle != nil) {
        NSDictionary *attributes = @{
            NSForegroundColorAttributeName : [self colorWithHexString:@"#333333"],
            NSFontAttributeName : [UIFont boldSystemFontOfSize:20.0]
        };
        model.alertTitle = [[NSAttributedString alloc] initWithString:alertTitle attributes:attributes];
    }
    model.alertCloseImage = [UIImage imageNamed:@"icon_close_light"];
    
    NSString *alertTitleHeight =[config objectForKey:[self methodName2KeyName:@"setAlertTitleHeight"]];
    if (alertTitleHeight != nil) {
        model.alertTitleBarFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
            CGRect newFrame = frame;
            newFrame.size.height = [alertTitleHeight floatValue];
            return newFrame;
        };
    }
    
   
//    logo
    [self setLogoViewWithModal:model config:config];
//    slogan
    [self setSloganViewWithModel:model config:config];
    // number
    [self setPhoneNumberViewWithModel:model config:config];
    //    orivacy协议
    [self setOrivacyViewWithModel:model config:config];
    
    // slogan
    [self setSloganViewWithModel:model config:config];
    // logBtn
    [self setLoginBtnViewWithModel:model config:config];
    // switch
    [self setSwitchViewWithModel:model config:config];
    // orivacy
    [self setOrivacyViewWithModel:model config:config];
    
    NSString *showCustomTitle =[config objectForKey:[self methodName2KeyName:@"setShowCustomTitle"]];
    if([showCustomTitle boolValue]){
//        展示自定义标题
        
        NSString *firstTitle =[config objectForKey:[self methodName2KeyName:@"setFirstTitle"]];
        UIButton *button1 = nil;
        if (firstTitle != nil) {
            button1 = [UIButton buttonWithType:UIButtonTypeSystem];
            [button1 setTitle:firstTitle forState:UIControlStateNormal];
            NSString *firstTitleColor =[config objectForKey:[self methodName2KeyName:@"setFirstTitleColor"]];
            if (firstTitleColor != nil) {
                [button1 setTitleColor:[self colorWithHexString:firstTitleColor] forState:UIControlStateNormal];
            }
            NSString *firstTitleFontSize =[config objectForKey:[self methodName2KeyName:@"setFirstTitleFontSize"]];
            if (firstTitleFontSize != nil) {
                NSString *firstTitleIsBold =[config objectForKey:[self methodName2KeyName:@"setFirstTitleIsBold"]];
                if (firstTitleIsBold != nil && [firstTitleIsBold boolValue]) {
                    button1.titleLabel.font = [UIFont boldSystemFontOfSize:[firstTitleFontSize floatValue]];
                }else{
                    button1.titleLabel.font = [UIFont systemFontOfSize:[firstTitleFontSize floatValue]];
                }
            }
            
            NSString *firstTitleAlignment =[config objectForKey:[self methodName2KeyName:@"setFirstTitleAlignment"]];
            button1.contentHorizontalAlignment = [firstTitleAlignment integerValue];
            NSString *firstTitleIsClick =[config objectForKey:[self methodName2KeyName:@"setFirstTitleIsClick"]];
            if (firstTitleIsClick != nil) {
                button1.btnImageName = firstTitle;
                block(button1);
            }
        }
        
        NSString *secondTitle =[config objectForKey:[self methodName2KeyName:@"setSecondTitle"]];
        if (secondTitle != nil) {
            UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
            [button2 setTitle:secondTitle forState:UIControlStateNormal];
            NSString *secondTitleColor =[config objectForKey:[self methodName2KeyName:@"setSecondTitleColor"]];
            if (secondTitleColor != nil) {
                [button2 setTitleColor:[self colorWithHexString:secondTitleColor] forState:UIControlStateNormal];
            }
            NSString *secondTitleFontSize =[config objectForKey:[self methodName2KeyName:@"setSecondTitleFontSize"]];
            if (secondTitleFontSize != nil) {
                NSString *secondTitleIsBold =[config objectForKey:[self methodName2KeyName:@"setSecondTitleIsBold"]];
                if (secondTitleIsBold != nil && [secondTitleIsBold boolValue]) {
                    button2.titleLabel.font = [UIFont boldSystemFontOfSize:[secondTitleFontSize floatValue]];
                }else{
                    button2.titleLabel.font = [UIFont systemFontOfSize:[secondTitleFontSize floatValue]];
                }
            }
            NSString *secondTitleAlignment =[config objectForKey:[self methodName2KeyName:@"setSecondTitleAlignment"]];
            button2.contentHorizontalAlignment = [secondTitleAlignment integerValue];

            NSString *secondTitleIsClick =[config objectForKey:[self methodName2KeyName:@"setSecondTitleIsClick"]];
            if (secondTitleIsClick != nil) {
                button2.btnImageName = secondTitle;
                block(button2);
            }
            model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
                [superCustomView addSubview:button1];
                [superCustomView addSubview:button2];
            };
            model.customViewLayoutBlock = ^(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
                NSString *TitleOffsetX =[config objectForKey:[self methodName2KeyName:@"setFirstTitleOffsetX"]];
                CGFloat x1 = TitleOffsetX != nil ? [TitleOffsetX floatValue] :CGRectGetMinX(loginFrame);
                NSString *TitleOffsetY =[config objectForKey:[self methodName2KeyName:@"setFirstTitleOffsetY"]];
                CGFloat y1 =TitleOffsetY != nil ? [TitleOffsetY floatValue] :CGRectGetMaxY(changeBtnFrame) + 15;
                NSString *TitleHeight =[config objectForKey:[self methodName2KeyName:@"setFirstTitleHeight"]];
                CGFloat height1 =TitleHeight != nil ? [TitleHeight floatValue] :25;
                button1.frame = CGRectMake(x1,y1,CGRectGetWidth(contentViewFrame)-x1*2,height1);
                
                NSString *firstTitleOffsetX =[config objectForKey:[self methodName2KeyName:@"setSecondTitleOffsetX"]];
                CGFloat x = firstTitleOffsetX != nil ? [firstTitleOffsetX floatValue] :CGRectGetMinX(loginFrame);
                NSString *firstTitleOffsetY =[config objectForKey:[self methodName2KeyName:@"setSecondTitleOffsetY"]];
                CGFloat y =firstTitleOffsetY != nil ? [firstTitleOffsetY floatValue] :CGRectGetMaxY(changeBtnFrame) + 15;
                NSString *firstTitleHeight =[config objectForKey:[self methodName2KeyName:@"setSecondTitleHeight"]];
                CGFloat height =firstTitleHeight != nil ? [firstTitleHeight floatValue] :25;
                button2.frame = CGRectMake(x,y,CGRectGetWidth(contentViewFrame)-x*2,height);
            };
        }else{
            model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
                [superCustomView addSubview:button1];
            };
            model.customViewLayoutBlock = ^(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
                NSString *firstTitleOffsetX =[config objectForKey:[self methodName2KeyName:@"setFirstTitleOffsetX"]];
                CGFloat x = firstTitleOffsetX != nil ? [firstTitleOffsetX floatValue] :CGRectGetMinX(loginFrame);
                NSString *firstTitleOffsetY =[config objectForKey:[self methodName2KeyName:@"setFirstTitleOffsetY"]];
                CGFloat y =firstTitleOffsetY != nil ? [firstTitleOffsetY floatValue] :CGRectGetMaxY(changeBtnFrame) + 15;
                NSString *firstTitleHeight =[config objectForKey:[self methodName2KeyName:@"setFirstTitleHeight"]];
                CGFloat height =firstTitleHeight != nil ? [firstTitleHeight floatValue] :25;
                button1.frame = CGRectMake(x,y,CGRectGetWidth(contentViewFrame)-x*2,height);
            };
        }
    }
    
    model.contentViewFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.size.width = superViewSize.width;
        frame.size.height = 460;
        frame.origin.x = 0;
        frame.origin.y = superViewSize.height - frame.size.height;
        return frame;
    };
    return model;
}

#pragma mark - logo
+ (void)setLogoViewWithModal:(TXCustomModel *)model config:(NSDictionary *)config{
    NSString *logoImgPath = [config objectForKey:[self methodName2KeyName:@"setLogoImgPath"]];
    if (logoImgPath != nil) {
        model.logoImage = [UIImage imageNamed:logoImgPath];
    }
    NSString *logoHidden = [config objectForKey:[self methodName2KeyName:@"setLogoHidden"]];
    if (logoHidden != nil) {
        model.logoIsHidden = [logoHidden boolValue];
    }

    NSString *alertlogoWidth = [config objectForKey:[self methodName2KeyName:@"setLogoWidth"]];
    NSString *alertlogoHeight = [config objectForKey:[self methodName2KeyName:@"setLogoHeight"]];
    
    CGFloat logoWidth = 30;
    CGFloat logoHeight = 30;
    if (alertlogoWidth != nil) {
        logoWidth = [alertlogoWidth floatValue];
    }
    if (alertlogoHeight != nil) {
        logoHeight = [alertlogoHeight floatValue];
    }

    NSString *logoOffsetY = [config objectForKey:[self methodName2KeyName:@"setLogoOffsetY"]];
    NSString *logoOffsetX = [config objectForKey:[self methodName2KeyName:@"setLogoOffsetX"]];

    model.logoFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat x = (superViewSize.width - logoWidth)/2;
        CGFloat y = frame.origin.y;
//        CGFloat width = frame.size.width;
//        CGFloat height = frame.size.height;
        if (logoOffsetY != nil) {
            y = [logoOffsetY floatValue];
        }
        if (logoOffsetX != nil) {
            x = [logoOffsetX floatValue];
        }
        return CGRectMake(x, y, logoWidth, logoHeight);
    };
}
#pragma mark - 手机号
+(void)setPhoneNumberViewWithModel:(TXCustomModel *)model config:(NSDictionary *)config{
    NSString *numberColor = [config objectForKey:[self methodName2KeyName:@"setNumberColor"]];
    if (numberColor != nil) {
        model.numberColor = [self colorWithHexString:numberColor];
    }
    NSString *numberSize = [config objectForKey:[self methodName2KeyName:@"setNumberSize"]];
    if (numberSize != nil) {
        model.numberFont = [UIFont boldSystemFontOfSize:[numberSize floatValue]];
    }
    NSString *numberFieldOffsetX = [config objectForKey:[self methodName2KeyName:@"setNumberFieldOffsetX"]];
    NSString *numberFieldOffsetY = [config objectForKey:[self methodName2KeyName:@"setNumberFieldOffsetY"]];
    model.numberFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat x = frame.origin.x;
        CGFloat y = frame.origin.y;
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        if (numberFieldOffsetX != nil) {
            x = [numberFieldOffsetY floatValue];
        }
        if (numberFieldOffsetY != nil) {
            y = [numberFieldOffsetY floatValue];
        }
        return CGRectMake(x, y, width, height);
    };
}

#pragma mark - slogan
+(void)setSloganViewWithModel:(TXCustomModel *)model config:(NSDictionary *)config{
    NSString *sloganText = [config objectForKey:[self methodName2KeyName:@"setSloganText"]];
    NSString *sloganTextColor = [config objectForKey:[self methodName2KeyName:@"setSloganTextColor"]];
    NSString *sloganTextSize = [config objectForKey:[self methodName2KeyName:@"setSloganTextSize"]];
    if (sloganText != nil && sloganTextColor != nil && sloganTextSize != nil) {
        model.sloganText = [[NSAttributedString alloc]initWithString:sloganText attributes:@{NSForegroundColorAttributeName: [self colorWithHexString:sloganTextColor], NSFontAttributeName:[UIFont systemFontOfSize:[sloganTextSize doubleValue]]}];
    }
    NSString *sloganOffsetY = [config objectForKey:[self methodName2KeyName:@"setSloganOffsetY"]];
    model.sloganFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat x = frame.origin.x;
        CGFloat y = frame.origin.y;
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        if (sloganOffsetY != nil) {
            y = [sloganOffsetY floatValue];
        }
        return CGRectMake(x, y, width, height);
    };
}

#pragma mark - 底部协议orivacy
+ (void)setOrivacyViewWithModel:(TXCustomModel *)model config:(NSDictionary *)config{
    NSString *checkboxHidden = [config objectForKey:[self methodName2KeyName:@"setCheckboxHidden"]];
    if (checkboxHidden != nil) {
        model.checkBoxIsHidden = [checkboxHidden boolValue];
        
        if ([checkboxHidden boolValue]) {
            NSArray *checkBoxImages = [config objectForKey:[self methodName2KeyName:@"setCheckBoxImages"]];
            NSLog(@"checkBoxImages>>>:%@",checkBoxImages);
            if (checkBoxImages != nil ) {
                model.checkBoxImages=@[[UIImage imageNamed:[NSString stringWithFormat:@"%@",[checkBoxImages firstObject]]],[UIImage imageNamed:[NSString stringWithFormat:@"%@",[checkBoxImages lastObject]]]];
                
                CGFloat checkBoxWH = [[config objectForKey:[self methodName2KeyName:@"setCheckBoxWH"]] floatValue];
                model.checkBoxWH = checkBoxWH;
            }
        }
    }
    
    model.privacyAlignment = NSTextAlignmentCenter; // 与安卓保持一致
    NSString *appPrivacyOneName = [config objectForKey:[self methodName2KeyName:@"setAppPrivacyOneName"]];
    NSString *appPrivacyOneUrl = [config objectForKey:[self methodName2KeyName:@"setAppPrivacyOneUrl"]];
    if (appPrivacyOneName != nil && appPrivacyOneUrl != nil) {
        model.privacyOne = @[appPrivacyOneName, appPrivacyOneUrl];
    }
    NSString *appPrivacyTwoName = [config objectForKey:[self methodName2KeyName:@"setAppPrivacyTwoName"]];
    NSString *appPrivacyTwoUrl = [config objectForKey:[self methodName2KeyName:@"setAppPrivacyTwoUrl"]];
    if (appPrivacyTwoName != nil && appPrivacyTwoUrl != nil) {
        model.privacyTwo = @[appPrivacyTwoName, appPrivacyTwoUrl];
    }
    NSString *privacyState = [config objectForKey:[self methodName2KeyName:@"setPrivacyState"]];
    if (privacyState != nil) {
        model.checkBoxIsChecked = [privacyState boolValue];
    }
    NSString *privacyTextSize = [config objectForKey:[self methodName2KeyName:@"setPrivacyTextSize"]];
    if (privacyTextSize != nil) {
        model.privacyFont = [UIFont systemFontOfSize:[privacyTextSize floatValue]];
    }
    NSString *appPrivacyBaseColor = [config objectForKey:[self methodName2KeyName:@"setAppPrivacyBaseColor"]];
    NSString *appPrivacyColor = [config objectForKey:[self methodName2KeyName:@"setAppPrivacyColor"]];
    if (appPrivacyBaseColor != nil && appPrivacyColor != nil) {
        model.privacyColors = @[[self colorWithHexString:appPrivacyBaseColor], [self colorWithHexString:appPrivacyColor]];
    }
    NSString *vendorPrivacyPrefix = [config objectForKey:[self methodName2KeyName:@"setVendorPrivacyPrefix"]];
    NSString *vendorPrivacySuffix = [config objectForKey:[self methodName2KeyName:@"setVendorPrivacySuffix"]];
    if (vendorPrivacyPrefix != nil) {
        model.privacyOperatorPreText = vendorPrivacyPrefix;
    }
    if (vendorPrivacySuffix != nil) {
        model.privacyOperatorSufText = vendorPrivacySuffix;
    }
    NSString *privacyBefore = [config objectForKey:[self methodName2KeyName:@"setPrivacyBefore"]];
    NSString *privacyEnd = [config objectForKey:[self methodName2KeyName:@"setPrivacyEnd"]];
    if (privacyBefore != nil) {
        model.privacyPreText = privacyBefore;
    }
    if (vendorPrivacySuffix != nil) {
        model.privacySufText = privacyEnd;
    }
   
    NSString *privacyBottomOffsetY = [config objectForKey:[self methodName2KeyName:@"setPrivacyBottomOffsetY"]];
    model.privacyFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat x = frame.origin.x;
        CGFloat y = frame.origin.y;
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        if (privacyBottomOffsetY != nil) {
            y = y - [privacyBottomOffsetY floatValue];
        }
        return CGRectMake(x, y, width, height);
    };
}

#pragma mark - 登录按钮
+(void)setLoginBtnViewWithModel:(TXCustomModel *)model config:(NSDictionary *)config{
    NSString *logBtnText = [config objectForKey:[self methodName2KeyName:@"setLogBtnText"]];
    NSString *logBtnTextColor = [config objectForKey:[self methodName2KeyName:@"setLogBtnTextColor"]];
    NSString *logBtnTextSize = [config objectForKey:[self methodName2KeyName:@"setLogBtnTextSize"]];
    if (logBtnText != nil && logBtnTextColor != nil && logBtnTextSize != nil) {
        model.loginBtnText = [[NSAttributedString alloc]initWithString:logBtnText attributes:@{NSForegroundColorAttributeName: [self colorWithHexString:logBtnTextColor], NSFontAttributeName:[UIFont systemFontOfSize:[logBtnTextSize doubleValue]]}];
    }
    NSArray<NSString *> *logBtnBackgroundPaths = [config objectForKey:[self methodName2KeyName:@"setLogBtnBackgroundPaths"]];
    if (logBtnBackgroundPaths != nil) {
        model.loginBtnBgImgs = @[[UIImage imageNamed:logBtnBackgroundPaths[0]], [UIImage imageNamed:logBtnBackgroundPaths[1]], [UIImage imageNamed:logBtnBackgroundPaths[2]]];
    }
    model.autoHideLoginLoading = NO; // 与安卓保持一致
    NSString *logBtnMarginLeftAndRight = [config objectForKey:[self methodName2KeyName:@"setLogBtnMarginLeftAndRight"]];
    NSString *logBtnOffsetY = [config objectForKey:[self methodName2KeyName:@"setLogBtnOffsetY"]];
    model.loginBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat x = frame.origin.x;
        CGFloat y = frame.origin.y;
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        if (logBtnOffsetY != nil) {
            y = [logBtnOffsetY floatValue];
        }
        if (logBtnMarginLeftAndRight != nil) {
            width = screenSize.width - [logBtnMarginLeftAndRight floatValue] * 2;
            x = [logBtnMarginLeftAndRight floatValue];
        }
        return CGRectMake(x, y, width, height);
    };
}

#pragma mark - switch 其他登录方式
+ (void)setSwitchViewWithModel:(TXCustomModel *)model config:(NSDictionary *)config{
    
    BOOL changeBtnIsHidden = [[config objectForKey:[self methodName2KeyName:@"setChangeBtnIsHidden"]] boolValue];
    if (changeBtnIsHidden) {
        model.changeBtnIsHidden = YES;
        return;
    }
    
    NSString *switchAccText = [config objectForKey:[self methodName2KeyName:@"setSwitchAccText"]];
    NSString *switchAccTextColor = [config objectForKey:[self methodName2KeyName:@"setSwitchAccTextColor"]];
    NSString *switchAccTextSize = [config objectForKey:[self methodName2KeyName:@"setSwitchAccTextSize"]];
    if (switchAccText != nil && switchAccTextColor != nil && switchAccTextSize != nil) {
        model.changeBtnTitle = [[NSAttributedString alloc]initWithString:switchAccText attributes:@{NSForegroundColorAttributeName: [self colorWithHexString:switchAccTextColor], NSFontAttributeName:[UIFont systemFontOfSize:[switchAccTextSize doubleValue]]}];
    }
    NSString *switchAccHidden = [config objectForKey:[self methodName2KeyName:@"setSwitchAccHidden"]];
    if (switchAccHidden != nil) {
        model.changeBtnIsHidden = [switchAccHidden boolValue];
    }
    NSString *switchOffsetY = [config objectForKey:[self methodName2KeyName:@"setSwitchOffsetY"]];
    model.changeBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        CGFloat x = frame.origin.x;
        CGFloat y = frame.origin.y;
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        if (switchOffsetY != nil) {
            y = [switchOffsetY floatValue];
        }
        return CGRectMake(x, y, width, height);
    };
}
#pragma mark - 全屏相关

+ (TXCustomModel *)buildFullScreenPortraitModelWithButton1Title:(NSString *)button1Title
                                                        target1:(id)target1
                                                      selector1:(SEL)selector1
                                                   button2Title:(NSString *)button2Title
                                                        target2:(id)target2
                                                      selector2:(SEL)selector2 {
    TXCustomModel *model = [[TXCustomModel alloc] init];
    model.supportedInterfaceOrientations = UIInterfaceOrientationMaskPortrait;
    model.navColor = [UIColor orangeColor];
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSFontAttributeName : [UIFont systemFontOfSize:20.0]
    };
    model.navTitle = [[NSAttributedString alloc] initWithString:@"一键登录" attributes:attributes];
    model.navBackImage = [UIImage imageNamed:@"icon_nav_back_light"];
    model.logoImage = [UIImage imageNamed:@"taobao"];
    model.changeBtnIsHidden = YES;
    model.privacyOne = @[@"协议1", @"https://www.taobao.com"];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:button1Title forState:UIControlStateNormal];
    [button1 addTarget:target1 action:selector1 forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:button2Title forState:UIControlStateNormal];
    [button2 addTarget:target2 action:selector2 forControlEvents:UIControlEventTouchUpInside];
    
    model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
        [superCustomView addSubview:button1];
        [superCustomView addSubview:button2];
    };
    model.customViewLayoutBlock = ^(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
        button1.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                   CGRectGetMaxY(loginFrame) + 20,
                                   CGRectGetWidth(loginFrame),
                                   30);
        
        button2.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                   CGRectGetMaxY(button1.frame) + 15,
                                   CGRectGetWidth(loginFrame),
                                   30);
    };
    return model;
}

+ (TXCustomModel *)buildFullScreenLandscapeModelWithButton1Title:(NSString *)button1Title
                                                         target1:(id)target1
                                                       selector1:(SEL)selector1
                                                    button2Title:(NSString *)button2Title
                                                         target2:(id)target2
                                                       selector2:(SEL)selector2 {
    TXCustomModel *model = [[TXCustomModel alloc] init];
    model.supportedInterfaceOrientations = UIInterfaceOrientationMaskLandscape;
    model.navColor = [UIColor orangeColor];
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSFontAttributeName : [UIFont systemFontOfSize:20.0]
    };
    model.navTitle = [[NSAttributedString alloc] initWithString:@"一键登录" attributes:attributes];
    model.navBackImage = [UIImage imageNamed:@"icon_nav_back_light"];
    model.logoImage = [UIImage imageNamed:@"taobao"];
    model.sloganIsHidden = YES;
    model.changeBtnIsHidden = YES;
    model.privacyOne = @[@"协议1", @"https://www.taobao.com"];
    
    model.logoFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.size.width = 80;
        frame.size.height = 80;
        frame.origin.y = 15;
        frame.origin.x = (superViewSize.width - 80) * 0.5;
        return frame;
    };
    model.numberFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.origin.y = 15 + 80 + 15;
        return frame;
    };
    
    model.loginBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.origin.y = 110 + 30 + 20;
        return frame;
    };
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:button1Title forState:UIControlStateNormal];
    [button1 addTarget:target1 action:selector1 forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:button2Title forState:UIControlStateNormal];
    [button2 addTarget:target2 action:selector2 forControlEvents:UIControlEventTouchUpInside];
    
    model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
        [superCustomView addSubview:button1];
        [superCustomView addSubview:button2];
    };
    model.customViewLayoutBlock = ^(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
        button1.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                   CGRectGetMaxY(loginFrame) + 20,
                                   CGRectGetWidth(loginFrame) * 0.5,
                                   30);
        
        button2.frame = CGRectMake(CGRectGetMaxX(button1.frame),
                                   CGRectGetMinY(button1.frame),
                                   CGRectGetWidth(loginFrame) * 0.5,
                                   30);
    };
    return model;
}

+ (TXCustomModel *)buildFullScreenAutorotateModelWithButton1Title:(NSString *)button1Title
                                                          target1:(id)target1
                                                        selector1:(SEL)selector1
                                                     button2Title:(NSString *)button2Title
                                                          target2:(id)target2
                                                        selector2:(SEL)selector2 {
    TXCustomModel *model = [[TXCustomModel alloc] init];
    model.supportedInterfaceOrientations = UIInterfaceOrientationMaskAllButUpsideDown;
    model.navColor = [UIColor orangeColor];
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSFontAttributeName : [UIFont systemFontOfSize:20.0]
    };
    model.navTitle = [[NSAttributedString alloc] initWithString:@"一键登录" attributes:attributes];
    model.navBackImage = [UIImage imageNamed:@"icon_nav_back_light"];
    model.logoImage = [UIImage imageNamed:@"taobao"];
    model.changeBtnIsHidden = YES;
    model.privacyOne = @[@"协议1", @"https://www.taobao.com"];
    
    model.logoFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.size.width = 80;
        frame.size.height = 80;
        frame.origin.y = screenSize.height > screenSize.width ? 30 : 15;
        frame.origin.x = (superViewSize.width - 80) * 0.5;
        return frame;
    };
    model.sloganFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        if (screenSize.height > screenSize.width) {
            frame.size.width = superViewSize.width - 40;
            frame.size.height = 20;
            frame.origin.x = 20;
            frame.origin.y = 20 + 80 + 20;
            return frame;
        } else {
            return CGRectZero;
        }
    };
    model.numberFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        if (screenSize.height > screenSize.width) {
            frame.origin.y = 130 + 20 + 15;
        } else {
            frame.origin.y = 15 + 80 + 15;
        }
        return frame;
    };
    model.loginBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        if (screenSize.height > screenSize.width) {
            frame.origin.y = 170 + 30 + 20;
        } else {
            frame.origin.y = 110 + 30 + 20;
        }
        return frame;
    };
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:button1Title forState:UIControlStateNormal];
    [button1 addTarget:target1 action:selector1 forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:button2Title forState:UIControlStateNormal];
    [button2 addTarget:target2 action:selector2 forControlEvents:UIControlEventTouchUpInside];
    
    model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
        [superCustomView addSubview:button1];
        [superCustomView addSubview:button2];
    };
    model.customViewLayoutBlock = ^(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
        if (screenSize.height > screenSize.width) {
            button1.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                       CGRectGetMaxY(loginFrame) + 20,
                                       CGRectGetWidth(loginFrame),
                                       30);
            
            button2.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                       CGRectGetMaxY(button1.frame) + 15,
                                       CGRectGetWidth(loginFrame),
                                       30);
        } else {
            button1.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                       CGRectGetMaxY(loginFrame) + 20,
                                       CGRectGetWidth(loginFrame) * 0.5,
                                       30);
            
            button2.frame = CGRectMake(CGRectGetMaxX(button1.frame),
                                       CGRectGetMinY(button1.frame),
                                       CGRectGetWidth(loginFrame) * 0.5,
                                       30);
        }
    };
    return model;
}

#pragma mark - 弹窗

+ (TXCustomModel *)buildAlertPortraitModeWithButton1Title:(NSString *)button1Title
                                                  target1:(id)target1
                                                selector1:(SEL)selector1
                                             button2Title:(NSString *)button2Title
                                                  target2:(id)target2
                                                selector2:(SEL)selector2 {
    TXCustomModel *model = [[TXCustomModel alloc] init];
    model.supportedInterfaceOrientations = UIInterfaceOrientationMaskPortrait;
    model.alertCornerRadiusArray = @[@10, @10, @10, @10];
    model.alertTitleBarColor = [UIColor orangeColor];
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSFontAttributeName : [UIFont systemFontOfSize:20.0]
    };
    model.alertTitle = [[NSAttributedString alloc] initWithString:@"一键登录" attributes:attributes];
    model.alertCloseImage = [UIImage imageNamed:@"icon_close_light"];
    model.logoImage = [UIImage imageNamed:@"taobao"];
    model.changeBtnIsHidden = YES;
    model.privacyOne = @[@"协议1", @"https://www.taobao.com"];
    
    model.contentViewFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.size.width = superViewSize.width * 0.8;
        frame.size.height = frame.size.width / 0.618;
        frame.origin.x = (superViewSize.width - frame.size.width) * 0.5;
        frame.origin.y = (superViewSize.height - frame.size.height) * 0.5;
        return frame;
    };
    model.logoFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.size.width = 80;
        frame.size.height = 80;
        frame.origin.y = 20;
        frame.origin.x = (superViewSize.width - 80) * 0.5;
        return frame;
    };
    model.sloganFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.origin.y = 20 + 80 + 20;
        return frame;
    };
    model.numberFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.origin.y = 120 + 20 + 15;
        return frame;
    };
    model.loginBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.origin.y = 155 + 20 + 30;
        return frame;
    };
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:button1Title forState:UIControlStateNormal];
    [button1 addTarget:target1 action:selector1 forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:button2Title forState:UIControlStateNormal];
    [button2 addTarget:target2 action:selector2 forControlEvents:UIControlEventTouchUpInside];
    
    model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
        [superCustomView addSubview:button1];
        [superCustomView addSubview:button2];
    };
    model.customViewLayoutBlock = ^(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
        button1.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                   CGRectGetMaxY(loginFrame) + 20,
                                   CGRectGetWidth(loginFrame),
                                   30);
        
        button2.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                   CGRectGetMaxY(button1.frame) + 15,
                                   CGRectGetWidth(loginFrame),
                                   30);
    };
    return model;
}

+ (TXCustomModel *)buildAlertLandscapeModeWithButton1Title:(NSString *)button1Title
                                                   target1:(id)target1
                                                 selector1:(SEL)selector1
                                              button2Title:(NSString *)button2Title
                                                   target2:(id)target2
                                                 selector2:(SEL)selector2 {
    TXCustomModel *model = [[TXCustomModel alloc] init];
    model.supportedInterfaceOrientations = UIInterfaceOrientationMaskLandscape;
    model.alertCornerRadiusArray = @[@10, @10, @10, @10];
    model.alertTitleBarColor = [UIColor orangeColor];
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSFontAttributeName : [UIFont systemFontOfSize:20.0]
    };
    model.alertTitle = [[NSAttributedString alloc] initWithString:@"一键登录" attributes:attributes];
    model.alertCloseImage = [UIImage imageNamed:@"icon_close_light"];
    model.logoIsHidden = YES;
    model.sloganIsHidden = YES;
    model.changeBtnIsHidden = YES;
    model.privacyOne = @[@"协议1", @"https://www.taobao.com"];
    
    model.contentViewFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.size.height = superViewSize.height * 0.8;
        frame.size.width = frame.size.height / 0.618;
        frame.origin.x = (superViewSize.width - frame.size.width) * 0.5;
        frame.origin.y = (superViewSize.height - frame.size.height) * 0.5;
        return frame;
    };
    model.numberFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.origin.y = 30;
        return frame;
    };
    model.loginBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.origin.y = 30 + 20 + 30;
        return frame;
    };
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:button1Title forState:UIControlStateNormal];
    [button1 addTarget:target1 action:selector1 forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:button2Title forState:UIControlStateNormal];
    [button2 addTarget:target2 action:selector2 forControlEvents:UIControlEventTouchUpInside];
    
    model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
        [superCustomView addSubview:button1];
        [superCustomView addSubview:button2];
    };
    model.customViewLayoutBlock = ^(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
        button1.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                   CGRectGetMaxY(loginFrame) + 20,
                                   CGRectGetWidth(loginFrame) * 0.5,
                                   30);
        
        button2.frame = CGRectMake(CGRectGetMaxX(button1.frame),
                                   CGRectGetMinY(button1.frame),
                                   CGRectGetWidth(loginFrame) * 0.5,
                                   30);
    };
    return model;
}

+ (TXCustomModel *)buildAlertAutorotateModeWithButton1Title:(NSString *)button1Title
                                                    target1:(id)target1
                                                  selector1:(SEL)selector1
                                               button2Title:(NSString *)button2Title
                                                    target2:(id)target2
                                                  selector2:(SEL)selector2 {
    TXCustomModel *model = [[TXCustomModel alloc] init];
    model.supportedInterfaceOrientations = UIInterfaceOrientationMaskAllButUpsideDown;
    model.alertCornerRadiusArray = @[@10, @10, @10, @10];
    model.alertTitleBarColor = [UIColor orangeColor];
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSFontAttributeName : [UIFont systemFontOfSize:20.0]
    };
    model.alertTitle = [[NSAttributedString alloc] initWithString:@"一键登录" attributes:attributes];
    model.alertCloseImage = [UIImage imageNamed:@"icon_close_light"];
    model.logoImage = [UIImage imageNamed:@"taobao"];
    model.sloganIsHidden = YES;
    model.changeBtnIsHidden = YES;
    model.privacyOne = @[@"自定义协议", @"https://www.taobao.com"];
    
    model.contentViewFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        if (screenSize.height > screenSize.width) {
            frame.size.width = superViewSize.width * 0.8;
            frame.size.height = frame.size.width / 0.618;
        } else {
            frame.size.height = superViewSize.height * 0.8;
            frame.size.width = frame.size.height / 0.618;
        }
        frame.origin.x = (superViewSize.width - frame.size.width) * 0.5;
        frame.origin.y = (superViewSize.height - frame.size.height) * 0.5;
        return frame;
    };
    model.logoFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        if (screenSize.height > screenSize.width) {
            frame.size.width = 80;
            frame.size.height = 80;
            frame.origin.y = 20;
            frame.origin.x = (superViewSize.width - 80) * 0.5;
        } else {
            frame = CGRectZero;
        }
        return frame;
    };
    model.sloganFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        if (screenSize.height > screenSize.width) {
            frame.size.height = 20;
            frame.size.width = superViewSize.width - 40;
            frame.origin.x = 20;
            frame.origin.y = 20 + 80 + 20;
        } else {
            frame = CGRectZero;
        }
        return frame;
    };
    model.numberFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        if (screenSize.height > screenSize.width) {
            frame.origin.y = 120 + 20 + 15;
        } else {
            frame.origin.y = 30;
        }
        return frame;
    };
    model.loginBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        if (screenSize.height > screenSize.width) {
            frame.origin.y = 155 + 20 + 30;
        } else {
            frame.origin.y = 30 + 20 + 30;
        }
        return frame;
    };
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:button1Title forState:UIControlStateNormal];
    [button1 addTarget:target1 action:selector1 forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:button2Title forState:UIControlStateNormal];
    [button2 addTarget:target2 action:selector2 forControlEvents:UIControlEventTouchUpInside];
    
    model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
        [superCustomView addSubview:button1];
        [superCustomView addSubview:button2];
    };
    model.customViewLayoutBlock = ^(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
        if (screenSize.height > screenSize.width) {
            button1.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                       CGRectGetMaxY(loginFrame) + 20,
                                       CGRectGetWidth(loginFrame),
                                       30);
            
            button2.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                       CGRectGetMaxY(button1.frame) + 15,
                                       CGRectGetWidth(loginFrame),
                                       30);
        } else {
            button1.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                       CGRectGetMaxY(loginFrame) + 20,
                                       CGRectGetWidth(loginFrame) * 0.5,
                                       30);
            
            button2.frame = CGRectMake(CGRectGetMaxX(button1.frame),
                                       CGRectGetMinY(button1.frame),
                                       CGRectGetWidth(loginFrame) * 0.5,
                                       30);
        }
    };
    return model;
}

#pragma mark - 底部弹窗

+ (TXCustomModel *)buildSheetPortraitModelWithButton1Title:(NSString *)button1Title
                                                   target1:(id)target1
                                                 selector1:(SEL)selector1
                                              button2Title:(NSString *)button2Title
                                                   target2:(id)target2
                                                 selector2:(SEL)selector2 {
    TXCustomModel *model = [[TXCustomModel alloc] init];
    model.supportedInterfaceOrientations = UIInterfaceOrientationMaskPortrait;
    model.alertCornerRadiusArray = @[@10, @0, @0, @10];
    model.alertTitleBarColor = [UIColor orangeColor];
    NSDictionary *attributes = @{
        NSForegroundColorAttributeName : [UIColor whiteColor],
        NSFontAttributeName : [UIFont systemFontOfSize:20.0]
    };
    model.alertTitle = [[NSAttributedString alloc] initWithString:@"一键登录" attributes:attributes];
    model.alertCloseImage = [UIImage imageNamed:@"icon_close_light"];
    model.logoImage = [UIImage imageNamed:@"taobao"];
    model.changeBtnIsHidden = YES;
    model.privacyOne = @[@"协议1", @"https://www.taobao.com"];
    
    model.contentViewFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.size.width = superViewSize.width;
        frame.size.height = 460;
        frame.origin.x = 0;
        frame.origin.y = superViewSize.height - frame.size.height;
        return frame;
    };
    model.logoFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.size.width = 80;
        frame.size.height = 80;
        frame.origin.y = 20;
        frame.origin.x = (superViewSize.width - 80) * 0.5;
        return frame;
    };
    model.sloganFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.origin.y = 20 + 80 + 20;
        return frame;
    };
    model.numberFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.origin.y = 120 + 20 + 15;
        return frame;
    };
    model.loginBtnFrameBlock = ^CGRect(CGSize screenSize, CGSize superViewSize, CGRect frame) {
        frame.origin.y = 155 + 20 + 30;
        return frame;
    };
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button1 setTitle:button1Title forState:UIControlStateNormal];
    [button1 addTarget:target1 action:selector1 forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [button2 setTitle:button2Title forState:UIControlStateNormal];
    [button2 addTarget:target2 action:selector2 forControlEvents:UIControlEventTouchUpInside];
    
    model.customViewBlock = ^(UIView * _Nonnull superCustomView) {
        [superCustomView addSubview:button1];
        [superCustomView addSubview:button2];
    };
    model.customViewLayoutBlock = ^(CGSize screenSize, CGRect contentViewFrame, CGRect navFrame, CGRect titleBarFrame, CGRect logoFrame, CGRect sloganFrame, CGRect numberFrame, CGRect loginFrame, CGRect changeBtnFrame, CGRect privacyFrame) {
        button1.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                   CGRectGetMaxY(loginFrame) + 20,
                                   CGRectGetWidth(loginFrame),
                                   30);
        
        button2.frame = CGRectMake(CGRectGetMinX(loginFrame),
                                   CGRectGetMaxY(button1.frame) + 15,
                                   CGRectGetWidth(loginFrame),
                                   30);
    };
    return model;
}

#pragma mark - DIY 动画

#pragma mark - method
// 将方法名转为key名 主要是和安卓端的逻辑保持一致
+(NSString *)methodName2KeyName:(NSString *)methodName {
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
+ (UIColor *) colorWithHexString: (NSString *)color
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

@end
