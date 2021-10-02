//
//  UIButton+category.m
//  RNAliOnepass
//
//  Created by 霍文梦 on 2021/9/28.
//

#import "UIButton+category.h"
#import "objc/runtime.h"


//static const void * btnImageNameTag = &btnImageNameTag;

@implementation UIButton (category)

@dynamic btnImageName;

-(void)setBtnImageName:(NSString *)btnImageName {
    objc_setAssociatedObject(self, @selector(btnImageName), btnImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
 
-(NSString *)btnImageName {
  return objc_getAssociatedObject(self, @selector(btnImageName));
}
@end
