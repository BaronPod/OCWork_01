//
//  DetailsViewController.m
//  OCWork_01
//
//  Created by 李嘉 on 16/2/9.
//  Copyright © 2016年 李嘉. All rights reserved.
//

#import "DetailsViewController.h"
#import "WebViewJavascriptBridge.h"

@interface DetailsViewController ()

@property WebViewJavascriptBridge* bridge;

@end

@implementation DetailsViewController

- (void) viewWillAppear:(BOOL)animated {
    if (_bridge) {
        return;
    }
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    [WebViewJavascriptBridge enableLogging];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:webView];
    
    [_bridge registerHandler:@"testObjcCallback" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback Called: %@", data);
        responseCallback(@"Response from testObjcCallback");
    }];
    
    NSString* tmp = self.setStringText;
    [_bridge callHandler:@"testJavascriptHandler" data:tmp];
    
    //[self renderButtons:webView];
    [self loadExamplePage:webView];
}

- (void) webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinshLoad");
}

//- (void)renderButtons:(UIWebView*)webView {
//    UIFont* font = [UIFont fontWithName:@"HelveticaNeue" size:12.0];
//    
//    UIButton *callbackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [callbackButton setTitle:@"Call Handler" forState:UIControlStateNormal];
//    [callbackButton addTarget:self action:@selector(callHandler:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view insertSubview:callbackButton aboveSubview:webView];
//    callbackButton.frame = CGRectMake(10, 400, 100, 35);
//    callbackButton.titleLabel.font = font;
//}
//
//- (void)callHandler:(id)sender {
//    id data = @{ @"greetingFromObjc": @"Hi there, JS!" };
//    [_bridge callHandler:@"testJavascriptHandler" data:data responseCallback:^(id responseData) {
//        NSLog(@"testJavascriptHandler responsed: %@", responseData);
//    }];
//}

- (void)loadExamplePage:(UIWebView*)webView {
    NSString* htmlPath = [[NSBundle mainBundle] pathForResource:@"ExampleApp" ofType:@"html"];
    NSString* appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [webView loadHTMLString:appHtml baseURL:baseURL];
}

- (NSString *)setStringText {
    //NSString* str = @"";
    NSMutableString *allTitleStr =[NSMutableString stringWithString:@"<style type='text/css'> p.thicker{font-weight: 900}p.light{font-weight: 0}p{font-size: 108%}h2 {font-size: 120%}h3 {font-size: 80%}</style> <h2 class = 'thicker'>title</h2><h3>author    timer</h3><hr/>"];
    [allTitleStr replaceOccurrencesOfString:@"title" withString:_entity.tName options:NSCaseInsensitiveSearch range:[allTitleStr rangeOfString:@"title"]];
    [allTitleStr replaceOccurrencesOfString:@"author" withString:[NSString stringWithFormat:@"作者：%@&nbsp;&nbsp;", _entity.tCode] options:NSCaseInsensitiveSearch range:[allTitleStr rangeOfString:@"author"]];
    [allTitleStr replaceOccurrencesOfString:@"timer" withString:[NSString stringWithFormat:@"时间：%@", _entity.tCreateDate] options:NSCaseInsensitiveSearch range:[allTitleStr rangeOfString:@"timer"]];
    
    NSString* str5 = [allTitleStr stringByAppendingString:[NSString stringWithFormat:@"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%@", _entity.tDescription]];
    
    return str5;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
