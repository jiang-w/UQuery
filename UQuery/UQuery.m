//
//  Uquery.m
//  Uquery
//
//  Created by Frank on 14-7-17.
//  Copyright (c) 2014年 bigdata. All rights reserved.
//

#import "UQuery.h"
#import "FieldQuery.h"

@implementation UQuery

- (NSString *)serializeToJson;
{
    return nil;
}

+ (instancetype)DeserializeFromJson:(NSString *) jsonString
{
    return nil;
}

+ (instancetype)greaterWithKey:(NSString *) key andValue:(NSObject*) val
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:val andQueryType:greater];
    return query;
}

+ (instancetype)greaterOrEqualWithKey:(NSString *) key andValue:(NSObject*) val
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:val andQueryType:greaterOrEqual];
    return query;
}

+ (instancetype)lessWithKey:(NSString *) key andValue:(NSObject*) val
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:val andQueryType:less];
    return query;
}

+ (instancetype)lessOrEqualWithKey:(NSString *) key andValue:(NSObject*) val
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:val andQueryType:lessOrEqual];
    return query;
}

+ (instancetype)equalWithKey:(NSString *) key andValue:(NSObject*) val
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:val andQueryType:equal];
    return query;
}

+ (instancetype)notEqualWithKey:(NSString *) key andValue:(NSObject*) val
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:val andQueryType:notEqual];
    return query;
}


@end
