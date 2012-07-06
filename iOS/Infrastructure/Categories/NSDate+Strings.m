//
//  NSDate+Strings.m
//  iOS
//
//  Created by James Geurts on 7/6/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "NSDate+Strings.h"

@implementation NSDate (NSDate_Strings)

- (NSString*)toShortDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter stringFromDate:self];
}

- (NSString*)toLongDateString
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    return [formatter stringFromDate:self];
}

@end