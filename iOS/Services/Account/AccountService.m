//
//  AccountService.m
//  iOS
//
//  Created by James Geurts on 5/6/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "AccountService.h"
#import "User.h"

@implementation AccountService

static NSString *getAuthenticationTokenUrl = @"http://dmbstream.com/api/users/GetAuthenticationToken";
static NSString *getUserInfoByTokenUrl = @"http://dmbstream.com/api/users/current";

- (void)getUser:(NSString*)username password:(NSString*)password completionHandler:(void (^)(User*, NSError *))completionHandler
{
    [super performRequest:@"users/GetAuthenticationToken" httpMethod:HTTPMETHOD_POST username:username password:password params:nil convertHandler:^(NSDictionary *json){
        NSLog(@"%@", json);
        User *user = [[User alloc] initWithJson:json];
        return user;
    } completionHandler:completionHandler];
}

- (void)getUser:(NSString*)token completionHandler:(void (^)(User*, NSError *))completionHandler
{
    [super performRequest:@"users/current" httpMethod:HTTPMETHOD_POST username:token password:@"X" params:nil convertHandler:^(NSDictionary *json){
        NSLog(@"%@", json);
        User *user = [[User alloc] initWithJson:json];
        return user;
    } completionHandler:completionHandler];
}
@end