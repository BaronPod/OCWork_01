//
//  tMessage.h
//  OCWork_01
//
//  Created by 李嘉 on 16/1/5.
//  Copyright © 2016年 李嘉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface tMessage : NSObject

- (UIAlertController *)sendAlert:(NSString *)title message:(NSString *)msg alertStyle:(UIAlertControllerStyle)style actionTitle:(NSString *)actionTitle actionStyle:(UIAlertActionStyle)actionStyle;

@end
