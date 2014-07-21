//
//  Uquery.m
//  Uquery
//
//  Created by Frank on 14-7-17.
//  Copyright (c) 2014年 bigdata. All rights reserved.
//

#import "UQuery.h"
#import "FieldQuery.h"
#import "RelationQuery.h"

@implementation UQuery

- (NSString *)serializeToJson;
{
    return nil;
}

+ (instancetype)DeserializeFromJson:(NSString *) jsonString
{
    return [FieldQuery DeserializeFromJson:jsonString];
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

+ (instancetype)andRelationWithQuerise:(UQuery *) query,...
{
    RelationQuery *rq = [[RelationQuery alloc] initWithRelation:andRelation andFieldQuery:nil];
    va_list argList;
    id arg;
    if (query) {
        [rq.queries addObject:query];
        va_start(argList, query);
        while((arg = va_arg(argList,id))) {
            [rq.queries addObject:arg];
        }
        va_end(argList);
    }
    return rq;
}

+ (instancetype)orRelationWithQuerise:(UQuery *) query,...
{
    RelationQuery *rq = [[RelationQuery alloc] initWithRelation:orRelation andFieldQuery:nil];
    va_list argList;
    id arg;
    if (query) {
        [rq.queries addObject:query];
        va_start(argList, query);
        while((arg = va_arg(argList,id))) {
            [rq.queries addObject:arg];
        }
        va_end(argList);
    }
    return rq;
}

@end
