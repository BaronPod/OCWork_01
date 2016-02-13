//
//  httpHelp.m
//  OCWork_01
//
//  Created by 李嘉 on 16/1/5.
//  Copyright © 2016年 李嘉. All rights reserved.
//

#import "JsonHelp.h"
static NSString *const WSDL_SERVICE_URL = @"https://www.ibaron.net.cn/ws/";
static NSString *const WSDL_EXTEN_NAME = @".svc/";

@implementation JsonHelp

- (NSString *) base64Code:(NSString *)parameters {
    NSLog(@"json参数值为：%@", parameters);
    NSData *data = [parameters dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64 = [data base64EncodedStringWithOptions:0];
    NSLog(@"base64位加密后的值：%@", base64);
    return base64;
}

- (id) base64Decode:(id)modelObject parameter:(NSString *)parameter {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:parameter options:0];
    NSString *base64Decode = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64Decode;
}

- (id)base64DecodeArray:(NSString *)parameter {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:parameter options:0];
    NSError *err;
    //NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
    return result;
}

- (NSString *)getURLString:(NSString *)_url _serviceName:(serviceName)_serviceName _methodName:(methodName)_methodName _parameter:(NSString *)_parameter {
    NSString *resultURL = @"";
    NSString *__serviceName = [self getServiceName:_serviceName];
    NSString *__methodName  = [self getMehtodName:_methodName];
    if ([_url  isEqual: @""]) {
        resultURL = [resultURL stringByAppendingString:[NSString stringWithFormat:@"%@", WSDL_SERVICE_URL]];
        NSLog(@"第一次拼接：%@", resultURL);
        resultURL = [resultURL stringByAppendingString:[NSString stringWithFormat:@"%@", __serviceName]];
        NSLog(@"第二次拼接：%@", resultURL);
        resultURL = [resultURL stringByAppendingString:[NSString stringWithFormat:@"%@", __methodName]];
        NSLog(@"第三次拼接：%@", resultURL);
        resultURL = [resultURL stringByAppendingString:[NSString stringWithFormat:@"%@", _parameter]];
        NSLog(@"最后一次拼接：%@", resultURL);
    } else {
        resultURL = [resultURL stringByAppendingString:[NSString stringWithFormat:@"%@", _url]];
        NSLog(@"第一次拼接：%@", resultURL);
        resultURL = [resultURL stringByAppendingString:[NSString stringWithFormat:@"%@", __serviceName]];
        NSLog(@"第二次拼接：%@", resultURL);
        resultURL = [resultURL stringByAppendingString:[NSString stringWithFormat:@"%@", __methodName]];
        NSLog(@"第三次拼接：%@", resultURL);
        resultURL = [resultURL stringByAppendingString:[NSString stringWithFormat:@"%@", _parameter]];
        NSLog(@"最后一次拼接：%@", resultURL);
    }
    return resultURL;
}

+ (AFSecurityPolicy*)customSecurityPolicy {
    //证书路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ssl" ofType:@"cer"];
    NSLog(@"SSL证书路径：%@", cerPath);
    //导入证书
    NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果需要自建的证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES
    //假如证书的域名与请求的域名不一致，需要把该项设置为NO，如设成NO的话，即服务器使用其它机构认证的证书，也可以建立连接，这个非常危险，建议打开
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    
    securityPolicy.pinnedCertificates = @[cerData];
    
    return securityPolicy;
}

+ (void)post:(NSString *)_url params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    //获取请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申请返回的结果类型
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.securityPolicy = [self customSecurityPolicy];
    [manager.requestSerializer setTimeoutInterval:10];
    [manager POST:_url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];
}

+ (void) get:(NSString *)_url params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    //获取请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //申请返回的结果类型
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    manager.securityPolicy = [self customSecurityPolicy];
    [manager.requestSerializer setTimeoutInterval:10];
    [manager GET:_url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation, error);
        }
    }];
}

- (NSString *) getServiceName:(serviceName)_servicename {
    NSString *result = @"";
    switch (_servicename) {
        case BattachmentService:
            result = [NSString stringWithFormat:@"BattachmentService%@", WSDL_EXTEN_NAME];
            break;
        case BcommentService:
            result = [NSString stringWithFormat:@"BcommentService%@", WSDL_EXTEN_NAME];
            break;
        case BconfigService:
            result = [NSString stringWithFormat:@"BconfigService%@", WSDL_EXTEN_NAME];
            break;
        case BeventsService:
            result = [NSString stringWithFormat:@"BeventsService%@", WSDL_EXTEN_NAME];
            break;
        case BlogService:
            result = [NSString stringWithFormat:@"BlogService%@", WSDL_EXTEN_NAME];
            break;
        case BpraiseService:
            result = [NSString stringWithFormat:@"BpraiseService%@", WSDL_EXTEN_NAME];
            break;
        case BreplyService:
            result = [NSString stringWithFormat:@"BreplyService%@", WSDL_EXTEN_NAME];
            break;
        case BresourceService:
            result = [NSString stringWithFormat:@"BresourceService%@", WSDL_EXTEN_NAME];
            break;
        case BrolegroupService:
            result = [NSString stringWithFormat:@"BrolegroupService%@", WSDL_EXTEN_NAME];
            break;
        case BroleService:
            result = [NSString stringWithFormat:@"BroleService%@", WSDL_EXTEN_NAME];
            break;
        case BtypeService:
            result = [NSString stringWithFormat:@"BtypeService%@", WSDL_EXTEN_NAME];
            break;
        case BuserService:
            result = [NSString stringWithFormat:@"BuserService%@", WSDL_EXTEN_NAME];
            break;
        case V_attachment_eventService:
            result = [NSString stringWithFormat:@"V_attachment_eventService%@", WSDL_EXTEN_NAME];
            break;
        case V_event_userService:
            result = [NSString stringWithFormat:@"V_event_userService%@", WSDL_EXTEN_NAME];
            break;
        case V_list_attachmentService:
            result = [NSString stringWithFormat:@"V_list_attachmentService%@", WSDL_EXTEN_NAME];
            break;
        case V_resourceService:
            result = [NSString stringWithFormat:@"V_resourceService%@", WSDL_EXTEN_NAME];
            break;
        case V_userConfigService:
            result = [NSString stringWithFormat:@"V_userConfigService%@", WSDL_EXTEN_NAME];
            break;
        default:
            result = @"空";
            break;
    }
    return result;
}

- (NSString *) getMehtodName:(methodName)_methodName {
    NSString *result = @"";
    switch (_methodName) {
        case Save:
            result = @"Save";
            break;
        case Add:
            result = @"Add";
            break;
        case Insert:
            result = @"Insert";
            break;
        case Delete:
            result = @"Delete";
            break;
        case DeleteByWhere:
            result = @"DeleteByWhere";
            break;
        case Update:
            result = @"Update";
            break;
        case Edit:
            result = @"Edit";
            break;
        case Find:
            result = @"Find";
            break;
        case FindAll:
            result = @"FindAll";
            break;
        case FindObjs:
            result = @"FindObjs";
            break;
        case LoadAll:
            result = @"LoadAll";
            break;
        case LoadObjs:
            result = @"LoadObjs";
            break;
        default:
            result = @"空";
            break;
    }
    return result;
}

@end
