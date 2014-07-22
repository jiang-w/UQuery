//
//  FieldQuery.h
//  Uquery
//
//  Created by Frank on 14-7-17.
//  Copyright (c) 2014年 bigdata. All rights reserved.
//

#import "UQuery.h"

typedef enum {
    greater,
    greaterOrEqual,
    less,
    lessOrEqual,
    equal,
    notEqual,
    in,
    notIn,
    like
} QueryType;

@interface FieldQuery : UQuery

@property (readonly) NSString *key;
@property (readonly) NSObject *value;
@property (readonly) QueryType type;

- (instancetype)initKey:(NSString *) key andValue:(NSObject *) val andQueryType:(QueryType) typ;
+ (instancetype)generateFromDictionary:(NSDictionary *) dictionary;

@end
