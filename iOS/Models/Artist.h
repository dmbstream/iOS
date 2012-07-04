//
//  Artist.h
//  iOS
//
//  Created by James Geurts on 7/4/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Artist : NSObject { }

@property int id;
@property NSString *abbreviation;
@property NSString *name;

- (id)initWithJson:(NSDictionary*)json;

@end
