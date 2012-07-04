//
//  Concert.h
//  iOS
//
//  Created by James Geurts on 7/4/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Artist.h"
#import "Tour.h"
#import "Venue.h"

@interface Concert : NSObject { }

@property NSString *id;
@property NSString *name;
@property NSDate *date;
@property (strong) Artist *artist;
@property (strong) Tour *tour;
@property (strong) Venue *venue;
@property NSMutableArray *tracks;

- (id)initWithJson:(NSDictionary*)json;

@end
