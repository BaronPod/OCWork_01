//
//  DetailViewController.m
//  OCWork_01
//
//  Created by 李嘉 on 16/1/13.
//  Copyright © 2016年 李嘉. All rights reserved.
//

#import "DetailViewController.h"
#import "M80AttributedLabel.h"
#import "TYAttributedLabel.h"
#import "CoreTextLabel.h"

@interface DetailViewController ()

@property (nonatomic, retain) CoreTextLabel *coreLabel;

@end


@implementation DetailViewController

- (void)dataInit {
    // Do any additional setup after loading the view.
    NSString *text = @"";
    NSString *title = self.entity.tName;
    text = [text stringByAppendingString:[NSString stringWithFormat:@"%@\n", title]];
    
    NSString *userName = self.entity.tCode;
    text = [text stringByAppendingString:[NSString stringWithFormat:@"作者：%@\t\t\t", userName]];
    NSString *dateTime = self.entity.tCreateDate;
    text = [text stringByAppendingString:[NSString stringWithFormat:@"时间：%@\n", dateTime]];
    NSString *content = self.entity.tDescription;
    text = [text stringByAppendingString:[NSString stringWithFormat:@"\t%@", content]];
    //NSString *text = @"\t⬆️⬆️(UIImageView)总有一天你将破蛹而出，成长得比人们期待的还要美丽。\n\t但这个过程会很痛，会很辛苦，有时候还会觉得灰心。\n\t面对着汹涌而来的现实，觉得自己渺小无力。\n\t但这，也是生命的一部分，做好现在你能做的，然后，一切都会好的。→→(UIButton)\n\t我们都将孤独地长大，不要害怕。";
    
    M80AttributedLabel *label = [[M80AttributedLabel alloc] initWithFrame:CGRectZero];
    label.lineSpacing = 0.5;
    label.paragraphSpacing = 0.5;
    label.text = text;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [scrollView addSubview:label];
    [self.view addSubview:scrollView];
    
    CGSize labelSize = [label sizeThatFits:CGSizeMake(CGRectGetWidth(self.view.bounds) - 40, CGFLOAT_MAX)];
    [label setFrame:CGRectMake(20, 10, labelSize.width, labelSize.height)];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), labelSize.height + 20);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setCoreText {
    NSString *text = @"";
    NSString *title = self.entity.tName;
    text = [text stringByAppendingString:[NSString stringWithFormat:@"%@\n", title]];
    
    NSString *userName = self.entity.tCode;
    text = [text stringByAppendingString:[NSString stringWithFormat:@"作者：%@\t\t\t", userName]];
    NSString *dateTime = self.entity.tCreateDate;
    text = [text stringByAppendingString:[NSString stringWithFormat:@"时间：%@\n", dateTime]];
    NSString *content = self.entity.tDescription;
    text = [text stringByAppendingString:[NSString stringWithFormat:@"\t%@", content]];
    
    TYAttributedLabel *label = [[TYAttributedLabel alloc] initWithFrame:CGRectZero];
    NSArray *textArray = [text componentsSeparatedByString:@"\n"];
    
    NSInteger index = 0;
    for (NSString *txt in textArray) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:txt];
        
        if (index == 0) {
            [attributedString addAttributeTextColor:[UIColor blackColor]];
            [attributedString addAttributeFont:[UIFont systemFontOfSize:20]];
            [label appendTextAttributedString:attributedString];
        } else {
            [label appendText:txt];
        }
        index++;
    }
    [label sizeToFit];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [scrollView addSubview:label];
    [self.view addSubview:scrollView];
    
    CGSize labelSize = [label sizeThatFits:CGSizeMake(CGRectGetWidth(self.view.bounds) - 40, CGFLOAT_MAX)];
    [label setFrame:CGRectMake(20, 10, labelSize.width, labelSize.height)];
    scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.bounds), labelSize.height + 20);
}

//- (void) viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    NSString *text = @"";
//    NSString *title = self.entity.tName;
//    text = [text stringByAppendingString:[NSString stringWithFormat:@"%@\n", title]];
//    
//    NSString *userName = self.entity.tCode;
//    text = [text stringByAppendingString:[NSString stringWithFormat:@"作者：%@\t\t\t", userName]];
//    NSString *dateTime = self.entity.tCreateDate;
//    text = [text stringByAppendingString:[NSString stringWithFormat:@"时间：%@\n", dateTime]];
//    NSString *content = self.entity.tDescription;
//    text = [text stringByAppendingString:[NSString stringWithFormat:@"\t%@", content]];
//    
//    if (!_coreLabel) {
//        UIFont   * regularFont         = [UIFont fontWithName:@"Verdana" size:18];
//        UIFont   * boldFont            = [UIFont fontWithName:@"Verdana-Bold" size:18];
//        UIFont   * italicFont          = [UIFont fontWithName:@"Verdana-Italic" size:18];
//        UIFont   * boldItalicFont      = [UIFont fontWithName:@"Verdana-BoldItalic" size:18];
//        
//        UIColor  * boldTextColor       = [UIColor blueColor];
//        UIColor  * boldItalicTextColor = [UIColor redColor];
//        UIColor  * italicTextColor     = [UIColor yellowColor];
//        
//        _coreLabel = [[CoreTextLabel alloc] initWithFrame:CGRectZero];
//        _coreLabel.defaultFontSize = 18;
//        _coreLabel.font = regularFont;
//        _coreLabel.boldFont = boldFont;
//        _coreLabel.italicFont = italicFont;
//        _coreLabel.boldItalicFont = boldItalicFont;
//        _coreLabel.boldTextColor = boldTextColor;
//        _coreLabel.boldItalicTextColor = boldItalicTextColor;
//        _coreLabel.italicTextColor = italicTextColor;
//        _coreLabel.textColor = [UIColor blackColor];
//        _coreLabel.text = text;
//    }
//    
//    [self.view addSubview:_coreLabel];
//}
//
//- (BOOL) shouldAutorotate {
//    return YES;
//}
//
//- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
//    return YES;
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
