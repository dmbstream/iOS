//
//  AccountService.h
//  iOS
//
//  Created by James Geurts on 5/6/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "Service.h"
#import "User.h"

@interface AccountService : Service

- (void)getUser:(NSString*)username password:(NSString*)password completionHandler:(void (^)(User*, NSError *))completionHandler;
- (void)getUser:(NSString*)token completionHandler:(void (^)(User*, NSError *))completionHandler;

@end