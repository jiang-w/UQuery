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

#pragma mark Serialize and Deserialize
- (NSString *)serializeToJson;
{
    return nil;
}

+ (instancetype)DeserializeFromJson:(NSString *)jsonString
{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    NSString *key = [NSString stringWithString:[jsonDic keyEnumerator].nextObject];
    
    if ([key isEqualToString:@"$and"] || [key isEqualToString:@"$or"]) {
        return [RelationQuery DeserializeFromJson:jsonString];
    }
    else
    {
        return [FieldQuery DeserializeFromJson:jsonString];
    }
}

#pragma mark Static Method
+ (instancetype)greaterWithKey:(NSString *)key andValue:(NSObject*)val
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:val andQueryType:greater];
    return query;
}

+ (instancetype)greaterOrEqualWithKey:(NSString *)key andValue:(NSObject*)val
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:val andQueryType:greaterOrEqual];
    return query;
}

+ (instancetype)lessWithKey:(NSString *)key andValue:(NSObject*)val
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:val andQueryType:less];
    return query;
}

+ (instancetype)lessOrEqualWithKey:(NSString *)key andValue:(NSObject*)val
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:val andQueryType:lessOrEqual];
    return query;
}

+ (instancetype)equalWithKey:(NSString *)key andValue:(NSObject*)val
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:val andQueryType:equal];
    return query;
}

+ (instancetype)notEqualWithKey:(NSString *)key andValue:(NSObject*)val
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:val andQueryType:notEqual];
    return query;
}

+ (instancetype)andRelationWithQuerise:(UQuery *)query,...
{
    NSMutableArray *queryArray = [NSMutableArray array];
    va_list argList;
    id arg = query;
    va_start(argList, query);
    while (arg) {
        [queryArray addObject:arg];
        arg = va_arg(argList,id);
    }
    va_end(argList);
    
    RelationQuery *rq = [[RelationQuery alloc] initWithRelation:andRelation andQueryArray:queryArray];
    return rq;
}

+ (instancetype)orRelationWithQuerise:(UQuery *)query,...
{
    NSMutableArray *queryArray = [NSMutableArray array];
    va_list argList;
    id arg = query;
    va_start(argList, query);
    while (arg) {
        [queryArray addObject:arg];
        arg = va_arg(argList,id);
    }
    va_end(argList);
    
    RelationQuery *rq = [[RelationQuery alloc] initWithRelation:orRelation andQueryArray:queryArray];
    return rq;
}

+ (instancetype)betweenWithKey:(NSString *)key fromValue:(NSObject *)from toValue:(NSObject *)to
{
    return [UQuery andRelationWithQuerise:[UQuery greaterOrEqualWithKey:key andValue:from], [UQuery lessOrEqualWithKey:key andValue:to], nil];
}

+ (instancetype)inWithKey:(NSString *)key fromArray:(NSArray *)array
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:array andQueryType:in];
    return query;
    
}

+ (instancetype)likeWithKey:(NSString *)key andRegexString:(NSString *)regexString
{
    FieldQuery *query = [[FieldQuery alloc] initKey:key andValue:regexString andQueryType:like];
    return query;
}

@end
