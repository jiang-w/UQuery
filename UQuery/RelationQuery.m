//
//  RelationQuery.m
//  UQuery
//
//  Created by Frank on 14-7-17.
//  Copyright (c) 2014年 bigdata. All rights reserved.
//

#import "RelationQuery.h"

#define Type_Mapping_Json @[@"$and", @"$or"]
#define TypeToJsonString(type) ([Type_Mapping_Json objectAtIndex:type])
#define TypeFromJsonString(string) ([Type_Mapping_Json indexOfObject:string])

@implementation RelationQuery

- (id)init
{
    if (self == [super init]) {
        _queries = [NSMutableSet setWithCapacity:2];
        _relation = andRelation;
    }
    return self;
}

- (instancetype)initWithRelation:(RelationType) relation andFieldQuery:(FieldQuery *) query,...
{
    if (self = [self init]) {
        _relation = relation;
        va_list argList;
        id arg;
        if (query) {
            [_queries addObject:query];
            va_start(argList, query);
            while((arg = va_arg(argList,id))) {
                [_queries addObject:arg];
            }
            va_end(argList);
        }
    }
    return self;
}

- (NSString *)serializeToJson
{
    NSString *json;
    if ([_queries count] > 1) {
        NSMutableArray *items = [NSMutableArray array];
        for (FieldQuery *fq in _queries) {
            [items addObject:[fq serializeToJson]];
        }
        json = [NSString stringWithFormat:@"{\"%@\":[%@]}"
                ,TypeToJsonString(_relation),[items componentsJoinedByString:@","]];
    }
    return json;
}

+ (instancetype)DeserializeFromJson:(NSString *) jsonString
{
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    
    RelationType typ = (int)TypeFromJsonString([[jsonDic allKeys] firstObject]);
    NSArray *values = [[jsonDic allValues] firstObject];
    
    RelationQuery *rq = [[RelationQuery alloc] init];
    rq -> _relation = typ;
    for (id item in values) {
        [rq.queries addObject:[FieldQuery generateFromDictionary:item]];
    }
    
    return rq;
}

- (BOOL)isEqual:(id)object
{
    if (object == nil) {
        return NO;
    }
    if (self == object) {
        return YES;
    }
    if ([object isMemberOfClass:[self class]]
        && _relation == [object relation]
        && [_queries isEqualToSet:[object queries]]) {
        return YES;
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
