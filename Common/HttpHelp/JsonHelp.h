//
//  httpHelp.h
//  OCWork_01
//
//  Created by 李嘉 on 16/1/5.
//  Copyright © 2016年 李嘉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "MJExtension/MJExtension.h"

@interface JsonHelp : NSObject

/**
 服务名称枚举值
 */
typedef enum {
    BattachmentService,
    BcommentService,
    BconfigService,
    BeventsService,
    BlogService,
    BpraiseService,
    BreplyService,
    BresourceService,
    BrolegroupService,
    BroleService,
    BtypeService,
    BuserService,
    V_attachment_eventService,
    V_event_userService,
    V_list_attachmentService,
    V_resourceService,
    V_userConfigService
}serviceName;

/**
 方法枚举值
 */
typedef enum {
    Save,
    Add,
    Insert,
    Delete,
    DeleteByWhere,
    Update,
    Edit,
    Find,
    LoadAll,
    FindAll,
    LoadObjs,
    FindObjs
}methodName;

/**
 *  @author 李嘉, 16-01-06 11:01:14
 *
 *  获取已格式化为Json字符串并且经过base64位加密的字符串
 *
 *  @param parameters: 参数值
 *
 *  @return: 返回加密后的字符串
 */
- (NSString *)base64Code:(NSString *)parameters;

/**
 *  @author 李嘉, 16-01-06 11:01:31
 *
 *  获取经过base64解密并且已通过Json反序列化后的对象
 *
 *  @param modelObject 模型对象
 *  @param parameter   json序列化并base64加密的字符串，暂时没有实现，传nil
 *
 *  @return 结果对象
 */
- (id)base64Decode:(id)modelObject parameter:(NSString *)parameter;

/**
 *  @author 李嘉, 16-01-11 16:01:46
 *
 *  获取经过base64解密并且已通过json反序列化后的对象
 *
 *  @param parameter 参数值
 *
 *  @return 数据对象
 */
- (id)base64DecodeArray:(NSString *)parameter;
/**
 *  @author 李嘉, 16-01-06 15:01:02
 *
 *  获取完整的URL服务地址
 *
 *  @param _url         url地址 如：http://www.baidu.com/
 *  @param _serviceName 服务名称 如：objList.svc/
 *  @param _methodName  方法名称 如：Find
 *  @param _parameter   参数值，没有则传""，否则在参数前加上"/"
 *
 *  @return 返回完整的地址
 */
- (NSString *)getURLString:(NSString *)_url _serviceName:(serviceName)_serviceName _methodName:(methodName)_methodName _parameter:(NSString *)_parameter;

/**
 *  @author 李嘉, 16-01-06 15:01:06
 *
 *  自定义SSL证书验证
 *
 *  @return SSL证书安全
 */
+ (AFSecurityPolicy*)customSecurityPolicy;

/**
 *  @author 李嘉, 16-01-07 13:01:46
 *
 *  POST数据请求
 *
 *  @param _url    url服务地址
 *  @param params  参数字典
 *  @param success 成功数据返回
 *  @param failure 错误数据返回
 */
+ (void)post:(NSString *)_url params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  @author 李嘉, 16-01-07 13:01:44
 *
 *  GET数据请求
 *
 *  @param _url    url服务地址
 *  @param params  参数字典
 *  @param success 成功数据返回
 *  @param failure 失败数据返回
 */
+ (void)get:(NSString *)_url params:(NSDictionary *)params success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  @author 李嘉, 16-01-06 17:01:31
 *
 *  获取服务名称字符串
 *
 *  @param _servicename 服务名称枚举
 *
 *  @return 返回字符串
 */
- (NSString *)getServiceName:(serviceName)_servicename;

/**
 *  @author 李嘉, 16-01-06 17:01:04
 *
 *  获取方法名称字符串
 *
 *  @param _methodName 方法名称枚举
 *
 *  @return 返回字符串
 */
- (NSString *)getMehtodName:(methodName)_methodName;

@end
