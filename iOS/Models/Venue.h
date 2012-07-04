//
//  Venue.h
//  iOS
//
//  Created by James Geurts on 7/4/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Venue : NSObject { }

@property int id;
@property NSString *name;

- (id)initWithJson:(NSDictionary*)json;

@end
