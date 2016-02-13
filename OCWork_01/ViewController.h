//
//  ViewController.h
//  OCWork_01
//
//  Created by 李嘉 on 16/1/5.
//  Copyright © 2016年 李嘉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtId;
@property (weak, nonatomic) IBOutlet UITextField *txtCode;
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtDesc;
@property (weak, nonatomic) IBOutlet UITextField *txtSource;
@property (weak, nonatomic) IBOutlet UITextField *txtStartDate;
@property (weak, nonatomic) IBOutlet UITextField *txtEndDate;
- (IBAction)btnSearch:(id)sender;
@end

