//
//  RelationQuery.h
//  UQuery
//
//  Created by Frank on 14-7-17.
//  Copyright (c) 2014年 bigdata. All rights reserved.
//

#import "UQuery.h"
#import "FieldQuery.h"

typedef enum {
    andRelation,
    orRelation
} RelationType;

@interface RelationQuery : UQuery

@property (readonly) RelationType relation;
@property (readonly) NSMutableSet *queries;

- (instancetype)initWithRelation:(RelationType) relation andFieldQuery:(FieldQuery *) query,...;
+ (RelationType)relationTypeFromJsonString:(NSString *) str;

@end
