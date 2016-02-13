//
//  ViewController.m
//  OCWork_01
//
//  Created by 李嘉 on 16/1/5.
//  Copyright © 2016年 李嘉. All rights reserved.
//

#import "ViewController.h"
#import "tMessage.h"
#import "JsonHelp.h"
#import "BtypeEntity.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)extracted_method:(NSString *)url {
    [JsonHelp get:url params:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSString *result = [dic valueForKeyPath:@"findResult"];
        NSLog(@"返回结果：%@", result);
        if (![result isEqualToString:@"bnVsbA=="]) {
            BtypeEntity *btype = [BtypeEntity alloc];
            btype = [btype mj_setKeyValues:[[JsonHelp alloc] base64Decode:nil parameter:result]];
            [_txtCode setText:btype.tCode];
            [_txtName setText:btype.tName];
            [_txtDesc setText:btype.tDescription];
            [_txtSource setText:btype.source];
            [_txtStartDate setText:btype.tCreateDate];
            [_txtEndDate setText:btype.tUpdateDate];
        } else {
            UIAlertController *alert = [[tMessage alloc] sendAlert:@"温馨提示" message:@"不好意思哦，没有找到你想要的结果哦！" alertStyle:UIAlertControllerStyleAlert actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        NSString *errLog = @"";
        if ([[error description] containsString:@"发生了 SSL 错误，无法建立与该服务器的安全连接。"]) {
            errLog = @"发生了 SSL 错误，无法建立与该服务器的安全连接。";
        } else {
            errLog = @"网络连接失败，请稍后重新尝试！";
        }
        UIAlertController *alert = [[tMessage alloc] sendAlert:@"温馨提示" message:[NSString stringWithFormat:@"%@", errLog] alertStyle:UIAlertControllerStyleAlert actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}

- (IBAction)btnSearch:(id)sender {
    if (![[_txtId text] isEqualToString:@""]) {
        NSLog(@"%@", [_txtId text]);
        NSString *json = [NSString stringWithFormat:@"{\"Id\":\"%@\"}", [_txtId text]];
        NSString *base64 = [[JsonHelp alloc] base64Code:json];
        NSString *para = [NSString stringWithFormat:@"/%@", base64];
        NSLog(@"json字符串：%@", para);
        NSString *url = [[JsonHelp alloc] getURLString:@"" _serviceName:BtypeService _methodName:Find _parameter:[NSString stringWithFormat:@"%@", para]];
        NSLog(@"url地址：%@", url);
        
        [self extracted_method:url];
    }
}
@end
