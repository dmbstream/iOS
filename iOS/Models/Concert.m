//
//  Concert.m
//  iOS
//
//  Created by James Geurts on 7/4/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "Concert.h"
#import "DotNetDateFormatter.h"
#import "Artist.h"
#import "Tour.h"
#import "Venue.h"
#import "Track.h"

@implementation Concert

@synthesize id = _id,
date = _date,
name = _name,
artist = _artist,
tour = _tour,
venue = _venue,
tracks = _tracks;


- (id)initWithJson:(NSDictionary*)json 
{
    if (!(self = [super init]))
		return nil;
    
    self.id = (NSString*)[json objectForKey:@"id"];
    self.name = (NSString*)[json objectForKey:@"name"];
    
    DotNetDateFormatter *formatter = [DotNetDateFormatter dotNetDateFormatter];    
    self.date = [formatter dateFromString:(NSString*)[json objectForKey:@"date"]];
    
    self.artist = [[Artist alloc] initWithJson:(NSDictionary*)[json objectForKey:@"artist"]];
    self.tour = [[Tour alloc] initWithJson:(NSDictionary*)[json objectForKey:@"tour"]];
    self.venue = [[Venue alloc] initWithJson:(NSDictionary*)[json objectForKey:@"venue"]];
    
    _tracks = [[NSMutableArray alloc] init];
    NSArray *trackArray = (NSArray*)[json objectForKey:@"tracks"];
    for (NSDictionary *track in trackArray) {
        Track *t = [[Track alloc] initWithJson:track];
        [_tracks addObject:t];
    }
    
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%@ - %@", self.id, self.name];
}

@end
