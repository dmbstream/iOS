//
//  Track.h
//  iOS
//
//  Created by James Geurts on 7/4/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject { }

@property NSString *id;
@property NSString *name;
@property NSString *url_high;
@property NSString *url_low;

- (id)initWithJson:(NSDictionary*)json;

@end
