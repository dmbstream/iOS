//
//  User.m
//  iOS
//
//  Created by James Geurts on 5/11/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize id = _id,
            username = _username,
            token = _token,
            isDonor = _isDonor;


- (id)initWithJson:(NSDictionary*)json 
{
    if (!(self = [super init]))
		return nil;
    
    self.id = (int)[json objectForKey:@"id"];
    self.username = (NSString*)[json objectForKey:@"username"];
    self.token = (NSString*)[json objectForKey:@"token"];
    self.isDonor = (BOOL)[json objectForKey:@"isDonor"];
    
    
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%d - %@", self.id, self.username];
}

@end
