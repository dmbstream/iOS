//
//  ConcertService.h
//  iOS
//
//  Created by James Geurts on 7/4/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Service.h"
#import "Concert.h"

@interface ConcertService : Service

- (void)getConcert:(NSString*)concertId completionHandler:(void (^)(Concert*, NSError *))completionHandler;

@end