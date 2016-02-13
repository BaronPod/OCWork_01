//
//  BtypeEntity.h
//  OCWork
//
//  Created by 李嘉 on 16/1/4.
//  Copyright © 2016年 李嘉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BtypeEntity : NSObject
@property (assign, nonatomic, readonly) NSNumber *tId;
@property (copy, nonatomic, readonly) NSString *tCode;
@property (copy, nonatomic, readonly) NSString *tName;
@property (copy, nonatomic, readonly) NSString *source;
@property (copy, nonatomic, readonly) NSString *tDescription;
@property (copy, nonatomic, readonly) NSString *tCreateDate;
@property (copy, nonatomic, readonly) NSString *tUpdateDate;
@property (copy, nonatomic, readonly) NSString *attribute1;
@property (copy, nonatomic, readonly) NSString *attribute2;
@property (copy, nonatomic, readonly) NSString *attribute3;
@property (copy, nonatomic, readonly) NSString *attribute4;
@property (copy, nonatomic, readonly) NSString *attribute5;
@property (copy, nonatomic, readonly) NSString *attribute6;
@property (copy, nonatomic, readonly) NSString *attribute7;
@property (copy, nonatomic, readonly) NSString *attribute8;
@property (copy, nonatomic, readonly) NSString *attribute9;
@property (copy, nonatomic, readonly) NSString *attribute10;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(instancetype)init:(NSString *)json;
@end
