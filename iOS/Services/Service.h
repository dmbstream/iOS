//
//  Service.h
//  iOS
//
//  Created by James Geurts on 5/6/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HTTPMETHOD_GET @"GET"
#define HTTPMETHOD_POST @"POST"

@interface Service : NSObject 

- (void) performRequest:(NSString*) url httpMethod:(NSString*)httpMethod username:(NSString*)username password:(NSString*)password params:(NSDictionary *)params convertHandler:(id (^)(NSDictionary*))convertHandler completionHandler:(void (^)(id, NSError *))completionHandler;

@end