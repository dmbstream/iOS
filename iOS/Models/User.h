//
//  User.h
//  iOS
//
//  Created by James Geurts on 5/11/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject { }

@property int id;
@property NSString *name;
@property BOOL isDonor;
@property NSString *token;

- (id)initWithJson:(NSDictionary*)json;

@end
