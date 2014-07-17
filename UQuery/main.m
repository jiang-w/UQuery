//
//  main.m
//  UQuery
//
//  Created by Frank on 14-7-17.
//  Copyright (c) 2014年 bigdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FieldQuery.h"
#import "RelationQuery.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        FieldQuery * fq1 = [[FieldQuery alloc] initKey:@"abc" andValue:[NSDate date] andQueryType:greater];
        FieldQuery * fq2 = [FieldQuery DeserializeFromJson:[fq1 serializeToJson]];
        
        NSLog(@"%@",fq1);
        NSLog(@"%@",fq2);
        
        if ([fq1 isEqual:fq2]) {
            printf("fq1 equal fq2\n");
        }
        else {
            printf("fq1 not equal fq2\n");
        }
        
        FieldQuery * fq3 = [[FieldQuery alloc] initKey:@"def" andValue:[NSNumber numberWithFloat:12.3] andQueryType:equal];
        RelationQuery *rq1 = [[RelationQuery alloc] initWithRelation:andRelation andFieldQuery:fq1,fq2,fq3,nil];
        NSLog(@"%@",rq1);
        RelationQuery *rq2 = [[RelationQuery alloc] initWithRelation:andRelation andFieldQuery:fq3,fq2,fq3,nil];
        NSLog(@"%@",rq2);
        
        if ([rq1 isEqual:rq2]) {
            printf("rq1 equal rq2\n");
        }
        else {
            printf("rq1 not equal rq2\n");
        }
    }
    return 0;
}


