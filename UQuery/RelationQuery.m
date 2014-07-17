//
//  RelationQuery.m
//  UQuery
//
//  Created by Frank on 14-7-17.
//  Copyright (c) 2014年 bigdata. All rights reserved.
//

#import "RelationQuery.h"

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
                ,[RelationQuery relationTypeToJsonString:_relation],[items componentsJoinedByString:@","]];
    }
    return json;
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

+ (NSString *)relationTypeToJsonString:(RelationType) relation
{
    NSString *label;
    switch (relation) {
        case andRelation:
            label = @"$and";
            break;
        case orRelation:
            label = @"$or";
            break;
        default:
            label = nil;
            break;
    }
    return label;
}

+ (RelationType)relationTypeFromJsonString:(NSString *) str
{
    RelationType typ;
    if ([str isEqualToString:@"$and"]) {
        typ = andRelation;
    } else if ([str isEqualToString:@"$or"]) {
        typ = orRelation;
    }
    else {
        typ = andRelation;
    }
    return typ;
}

@end
