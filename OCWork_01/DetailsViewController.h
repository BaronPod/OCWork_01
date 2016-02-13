//
//  DetailsViewController.h
//  OCWork_01
//
//  Created by 李嘉 on 16/2/9.
//  Copyright © 2016年 李嘉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BtypeEntity.h"

@interface DetailsViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic, strong) BtypeEntity *entity;

@end
