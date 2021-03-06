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
            name = _name,
            token = _token,
            isDonor = _isDonor;


- (id)initWithJson:(NSDictionary*)json 
{
    if (!(self = [super init]))
		return nil;
    
    self.id = (int)[json objectForKey:@"id"];
    self.name = (NSString*)[json objectForKey:@"name"];
    self.token = (NSString*)[json objectForKey:@"token"];
    self.isDonor = (BOOL)[json objectForKey:@"is_donor"];
    
    
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%d - %@", self.id, self.name];
}

@end
