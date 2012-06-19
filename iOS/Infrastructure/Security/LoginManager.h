//
//  LoginManager.h
//  iOS
//
//  Created by James Geurts on 5/28/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <Foundation/Foundation.h>

@class KeychainItemWrapper;
@interface LoginManager : NSObject
{
    KeychainItemWrapper *keychain;
}
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *token;

- (void)reset;

@end
