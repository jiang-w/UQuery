//
//  main.m
//  UQuery
//
//  Created by Frank on 14-7-17.
//  Copyright (c) 2014年 bigdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FieldQuery.h"

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
    }
    return 0;
}


