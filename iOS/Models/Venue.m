//
//  Venue.m
//  iOS
//
//  Created by James Geurts on 7/4/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "Venue.h"

@implementation Venue

@synthesize id = _id,
name = _name;


- (id)initWithJson:(NSDictionary*)json 
{
    if (!(self = [super init]))
		return nil;
    
    self.id = (int)[json objectForKey:@"id"];
    self.name = (NSString*)[json objectForKey:@"name"];
    
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%d - %@", self.id, self.name];
}

@end
