//
//  TableViewController.m
//  OCWork_01
//
//  Created by 李嘉 on 16/1/8.
//  Copyright © 2016年 李嘉. All rights reserved.
//

#import "TableViewController.h"
#import "customCell.h"
#import "BtypeEntity.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "JsonHelp.h"
#import "tMessage.h"
#import "DetailViewController.h"

//, UITableViewDelegate, UITableViewDataSource
@interface TableViewController () <UIActionSheetDelegate>
@property (strong, nonatomic) NSMutableArray *btypeEntitySections;
@property (copy, nonatomic) NSArray *entitiesFromJson;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.fd_debugLogEnabled = YES;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    //    [self.tableView setDelegate:self];
    //    [self.tableView setDataSource:self];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[self.tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"customCell"];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self buildDataThen:^{
        self.btypeEntitySections = @[].mutableCopy;
        [self.btypeEntitySections addObject:self.entitiesFromJson.mutableCopy];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildDataThen:(void (^)(void))then {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *where = [[JsonHelp alloc] base64Code:[[JsonHelp alloc] base64Code:@"\"\""]];
        NSString *json = [NSString stringWithFormat:@"{\"strWhere\": \"%@\",\"pageIndex\":\"1\",\"pageSize\":\"20\",\"totalCount\":\"0\"}", where];
        NSString *base64 = [[JsonHelp alloc] base64Code:json];
        NSString *para = [NSString stringWithFormat:@"/%@", base64];
        NSString *url = [[JsonHelp alloc] getURLString:@"" _serviceName:BtypeService _methodName:LoadObjs _parameter:[NSString stringWithFormat:@"%@", para]];
        NSLog(@"url地址：%@", url);
        
        [JsonHelp get:url params:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            NSString *result = [dic valueForKeyPath:@"LoadObjsResult"];
            NSLog(@"返回结果：%@", result);
            if ([result isEqualToString:@"bnVsbA=="]) {
                UIAlertController *alert = [[tMessage alloc] sendAlert:@"温馨提示" message:@"不好意思哦，目前暂时没有数据哦！" alertStyle:UIAlertControllerStyleAlert actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault];
                [self presentViewController:alert animated:YES completion:nil];
            } else {
                NSArray *btypeDict = [[JsonHelp alloc] base64DecodeArray:result];
                NSLog(@"数组长度为：%lu", (unsigned long)btypeDict.count);
                NSMutableArray *entities = @[].mutableCopy;
                [btypeDict enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    [entities addObject:[[BtypeEntity alloc] initWithDictionary:obj]];
                }];
                self.entitiesFromJson = entities;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                !then ?: then();
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
            NSString *errLog = @"";
            if ([[error description] containsString:@"发生了 SSL 错误，无法建立与该服务器的安全连接。"]) {
                errLog = @"发生了 SSL 错误，无法建立与该服务器的安全连接。";
            } else {
                errLog = @"网络连接失败，请稍后重试！";
            }
            UIAlertController *alert = [[tMessage alloc] sendAlert:@"温馨提示" message:[NSString stringWithFormat:@"%@", errLog] alertStyle:UIAlertControllerStyleAlert actionTitle:@"确定" actionStyle:UIAlertActionStyleDefault];
            [self presentViewController:alert animated:YES completion:nil];
        }];
    });
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.btypeEntitySections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.btypeEntitySections[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(CustomCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; //Enable to use "--sizeThatFits:"
    //    if (indexPath.row %2 == 0) {
    //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    } else {
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //    }
    cell.entity = self.btypeEntitySections[indexPath.section][indexPath.row];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //[tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"customCell"];
    return [tableView fd_heightForCellWithIdentifier:@"customCell" cacheByIndexPath:indexPath configuration:^(CustomCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    //传值给详情页面
//    DetailViewController *detail = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"DetailViewController"];
//    detail.entity = self.btypeEntitySections[indexPath.section][indexPath.row];
//    [self.navigationController pushViewController:detail animated:YES];
//}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSMutableArray *mutableEntities = self.btypeEntitySections[indexPath.section];
//        [mutableEntities removeObjectAtIndex:indexPath.row];
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toXQPage"]) {
        //获取当前索引
        NSIndexPath *index = [self.tableView indexPathForSelectedRow];
        
        DetailViewController *detail = segue.destinationViewController;
        BtypeEntity *entity12 = self.btypeEntitySections[index.section][index.row];
        detail.entity = entity12;
    }
}

@end
