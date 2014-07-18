//
//  FieldQuery.m
//  Uquery
//
//  Created by Frank on 14-7-17.
//  Copyright (c) 2014年 bigdata. All rights reserved.
//

#import "FieldQuery.h"

@implementation FieldQuery

- (instancetype)initKey:(NSString *) key andValue:(NSObject *) val andQueryType:(QueryType) typ
{
    if (self = [super init]) {
        _key = key;
        _value = val;
        _type = typ;
    }
    return self;
}

- (NSString *)serializeToJson
{
    NSString *json;
    id val;
    if([_value isKindOfClass:[NSDate class]]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        val = [dateFormatter stringFromDate:[NSDate date]];
    }
    else {
        val = _value;
    }
    
    if (_type != equal) {
        NSDictionary *tmp = [NSDictionary dictionaryWithObject:val forKey:[FieldQuery queryTypeToJsonString:_type]];
        val = tmp;
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObject:val forKey:_key];
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
        json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return json;
}

+ (instancetype)DeserializeFromJson:(NSString *) jsonString
{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    
    NSString *key = [NSString stringWithString:[jsonDic keyEnumerator].nextObject];
    id val = [jsonDic objectForKey:key];
    QueryType typ = equal;
    
    if ([val isKindOfClass:[NSDictionary class]]) {
        typ = [FieldQuery queryTypeFromJsonString:[val keyEnumerator].nextObject];
        val = [val objectEnumerator].nextObject;
    }
    
    if ([val isKindOfClass:[NSString class]]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSDate *date =[dateFormatter dateFromString:val];
        if(date) {
            val = date;
        }
    }
    
    return [[FieldQuery alloc] initKey:key andValue:val andQueryType:typ];
}

- (BOOL)isEqual:(id)object
{
    if (object == nil) {
        return NO;
    }
    if (self == object) {
        return YES;
    }
    if ([object isMemberOfClass:[self class]]) {
        if([[self serializeToJson] isEqualToString:[object serializeToJson]]) {
            return YES;
        }
        else {
            return NO;
        }
    }
    else {
        return NO;
    }
}

- (NSUInteger)hash
{
    return [[self serializeToJson] hash];
}

- (NSString *)description
{
    return [self serializeToJson];
}

+ (NSString *)queryTypeToJsonString:(QueryType) typ
{
    NSString *label;
    switch (typ) {
        case greater:
            label = @"$gt";
            break;
        case greaterOrEqual:
            label = @"$gte";
            break;
        case less:
            label = @"$lt";
            break;
        case lessOrEqual:
            label = @"$lte";
            break;
        case in:
            label = @"$in";
            break;
        case notIn:
            label = @"$nin";
            break;
        case like:
            label = @"$lk";
            break;
        case notEqual:
            label = @"$ne";
            break;
        default:
            label = nil;
            break;
    }
    return label;
}

+ (QueryType)queryTypeFromJsonString:(NSString *) str
{
    QueryType typ;
    if ([str isEqualToString:@"$gt"]) {
        typ = greater;
    }
    else if ([str isEqualToString:@"$gte"]) {
        typ = greaterOrEqual;
    }
    else if ([str isEqualToString:@"$lt"]) {
        typ = less;
    }
    else if ([str isEqualToString:@"$lte"]) {
        typ = lessOrEqual;
    }
    else if ([str isEqualToString:@"$in"]) {
        typ = in;
    }
    else if ([str isEqualToString:@"$nin"]) {
        typ = notIn;
    }
    else if ([str isEqualToString:@"$lk"]) {
        typ = like;
    }
    else if ([str isEqualToString:@"$ne"]) {
        typ = notEqual;
    }
    else {
        typ = equal;
    }
    return typ;
}

@end
