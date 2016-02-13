//
//  tMessage.m
//  OCWork_01
//
//  Created by 李嘉 on 16/1/5.
//  Copyright © 2016年 李嘉. All rights reserved.
//

#import "tMessage.h"

@implementation tMessage

- (UIAlertController *)sendAlert:(NSString *)title message:(NSString *)msg alertStyle:(UIAlertControllerStyle)style actionTitle:(NSString *)actionTitle actionStyle:(UIAlertActionStyle)actionStyle {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:style];
    UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:actionStyle handler:^(UIAlertAction * action){}];
    [alert addAction:action];
    return alert;
}

@end
