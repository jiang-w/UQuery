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

- (instancetype)initWithRelation:(RelationType) relation andQuerise:(UQuery *) query, ... NS_REQUIRES_NIL_TERMINATION;
- (void)addQueriseFromArray:(NSArray *) array;

@end
