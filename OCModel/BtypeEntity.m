//
//  BtypeEntity.m
//  OCWork
//
//  Created by 李嘉 on 16/1/4.
//  Copyright © 2016年 李嘉. All rights reserved.
//

#import "BtypeEntity.h"
#import "MJExtension/MJExtension.h"

@implementation BtypeEntity
- (instancetype)init:(NSString *)json
{
    BtypeEntity *model = [BtypeEntity mj_objectWithKeyValues:json];
    return model;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = super.init;
    if (self) {
        _tId = dictionary[@"tId"];
        _tCode = dictionary[@"tCode"];
        _tName = dictionary[@"tName"];
        _tCreateDate = dictionary[@"tCreateDate"];
        _tUpdateDate = dictionary[@"tUpdateDate"];
        _source = dictionary[@"source"];
        _tDescription = dictionary[@"tDescription"];
        _attribute1 = dictionary[@"attribute1"];
        _attribute2 = dictionary[@"attribute2"];
        _attribute3 = dictionary[@"attribute3"];
        _attribute4 = dictionary[@"attribute4"];
        _attribute5 = dictionary[@"attribute5"];
        _attribute6 = dictionary[@"attribute6"];
        _attribute7 = dictionary[@"attribute7"];
        _attribute8 = dictionary[@"attribute8"];
        _attribute9 = dictionary[@"attribute9"];
        _attribute10 = dictionary[@"attribute10"];
    }
    return self;
}
@end
