//
//  Track.m
//  iOS
//
//  Created by James Geurts on 7/4/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "Track.h"

@implementation Track

@synthesize id = _id,
name = _name,
duration = _duration,
url_high = _url_high,
url_low = _url_low;


- (id)initWithJson:(NSDictionary*)json 
{
    if (!(self = [super init]))
		return nil;
    
    self.id = (NSString*)[json objectForKey:@"id"];
    self.name = (NSString*)[json objectForKey:@"name"];
    self.duration = (NSString*)[json objectForKey:@"duration"];
    self.url_high = (NSString*)[json objectForKey:@"url_high"];
    self.url_low = (NSString*)[json objectForKey:@"url_low"];
    
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%@ - %@", self.id, self.name];
}

@end
