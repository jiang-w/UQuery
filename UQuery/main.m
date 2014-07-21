//
//  main.m
//  UQuery
//
//  Created by Frank on 14-7-17.
//  Copyright (c) 2014年 bigdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UQuery.h"
#import "RelationQuery.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        UQuery *uq1 = [UQuery greaterWithKey:@"abc" andValue:[NSDate date]];
        UQuery *uq2 = [UQuery equalWithKey:@"def" andValue:[NSNumber numberWithFloat:12.5]];
        UQuery *uq3 = [UQuery DeserializeFromJson:[uq1 serializeToJson]];
        UQuery *uq4 = [UQuery andRelationWithQuerise:uq1,uq2,uq3,nil];
        NSLog(@"%@",uq1);
        NSLog(@"%@",uq2);
        NSLog(@"%@",uq3);
        NSLog(@"%@",uq4);
        
        NSString *objClass = NSStringFromClass([UQuery class]);
        NSLog(@"%@",objClass);
    }
}
