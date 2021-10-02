//
//  SignWithApple.m
//  buyer
//
//  Created by Jonson on 2020/1/14.
//  Copyright © 2020 Jonson
//

#import "RNSignWithApple.h"
#import "RNSignWithAppleHelper.h"
#import "RNCoustomView.h"

@interface RNSignWithApple()
@property(nonatomic,copy)RNCoustomView  *imageView;

@end


@implementation RNSignWithApple

RCT_EXPORT_MODULE();
-(UIView *) view{
  
  _imageView = [[RNCoustomView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
  return self.imageView;
}

RCT_EXPORT_VIEW_PROPERTY(imageUrl, NSString)
RCT_EXPORT_VIEW_PROPERTY(onClick, RCTBubblingEventBlock)



@end
