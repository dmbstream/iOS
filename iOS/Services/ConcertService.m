//
//  ConcertService.m
//  iOS
//
//  Created by James Geurts on 7/4/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "ConcertService.h"
#import "Concert.h"
#import "LoginManager.h"

@implementation ConcertService

static NSString *getAuthenticationTokenUrl = @"http://dmbstream.com/api/users/GetAuthenticationToken";
static NSString *getUserInfoByTokenUrl = @"http://dmbstream.com/api/users/current";

- (void)getConcert:(NSString*)concertId completionHandler:(void (^)(Concert*, NSError *))completionHandler
{    
    NSString *url;
    if (concertId == CONCERT_RANDOM_ID) {
        url = @"concerts/random";
    } else {
        url = [NSString stringWithFormat:@"api/concerts/%@", concertId];
    }
    
    LoginManager *manager = [[LoginManager alloc] init];    
    [super performRequest:url httpMethod:HTTPMETHOD_POST username:manager.token password:@"X" params:nil convertHandler:^(NSDictionary *json){
        NSLog(@"%@", json);
        Concert *concert = [[Concert alloc] initWithJson:json];
        return concert;
    } completionHandler:completionHandler];
}

@end