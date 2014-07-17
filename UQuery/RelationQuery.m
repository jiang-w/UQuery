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
        _queries = [NSMutableArray array];
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
                if (![_queries containsObject:arg]) {
                    [_queries addObject:arg];
                }
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
        json = [NSString stringWithFormat:@"{\"%@\":[%@]}",[RelationQuery relationTypeToJsonString:_relation],[_queries componentsJoinedByString:@","]];
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
    if ([object isMemberOfClass:[self class]]) {
        RelationQuery *tmp = (RelationQuery *)object;
        if(_relation == tmp.relation && [_queries count] == [tmp.queries count]) {
            for (id item in tmp.queries) {
                if (![_queries containsObject:item]) {
                    return NO;
                }
            }
            for (id item in _queries) {
                if (![tmp.queries containsObject:item]) {
                    return NO;
                }
            }
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
