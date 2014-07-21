//
//  FieldQuery.m
//  Uquery
//
//  Created by Frank on 14-7-17.
//  Copyright (c) 2014年 bigdata. All rights reserved.
//

#import "FieldQuery.h"

#define Default_Date_Format @"yyyy-MM-dd'T'HH:mm:ss"
#define JsonArray [NSArray arrayWithObjects:@"$gt", @"$gte", @"$lt", @"$lte", @"$eq", @"$ne", @"$in", @"$nin",@"$lk", nil]
#define EnumToJsonString(type) ([JsonArray objectAtIndex:type])
#define EnumFromJsonString(string) ([JsonArray indexOfObject:string])

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
        [dateFormatter setDateFormat:Default_Date_Format];
        val = [dateFormatter stringFromDate:[NSDate date]];
    }
    else {
        val = _value;
    }
    
    if (_type != equal) {
        NSDictionary *tmp = [NSDictionary dictionaryWithObject:val forKey:EnumToJsonString(_type)];
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
        typ = (int)EnumFromJsonString([val keyEnumerator].nextObject);
        val = [val objectEnumerator].nextObject;
    }
    
    if ([val isKindOfClass:[NSString class]]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:Default_Date_Format];
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

@end
