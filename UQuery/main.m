//
//  main.m
//  UQuery
//
//  Created by Frank on 14-7-17.
//  Copyright (c) 2014年 bigdata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UQuery.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        
        UQuery *uq1 = [UQuery betweenWithKey:@"date" fromValue:[NSDate date] toValue:[NSDate date]];
        UQuery *uq2 = [UQuery equalWithKey:@"def" andValue:[NSNumber numberWithFloat:12.5]];
        UQuery *uq3 = [UQuery inWithKey:@"vals" fromArray:[NSArray arrayWithObjects:@"a",@"b",@"c",nil]];
        UQuery *uq4 = [UQuery andRelationWithQuerise:uq1,uq2,uq3,nil];
        NSLog(@"%@",uq1);
        NSLog(@"%@",uq2);
        NSLog(@"%@",uq3);
        NSLog(@"%@",uq4);
        
        UQuery *uq5 = [UQuery DeserializeFromJson:[uq4 serializeToJson]];
        NSLog(@"%@",uq5);

        NSString *objClass = NSStringFromClass([uq4 class]);
        NSLog(@"%@",objClass);
        
        if ([uq5 isEqual:uq4]) {
            printf("YES\n");
        }
        else
        {
            printf("NO\n");
        }
        
    }
}
