//
//  LoginManager.m
//  iOS
//
//  Created by James Geurts on 5/28/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "LoginManager.h"
#import "KeychainItemWrapper.h"

@implementation LoginManager

static NSString *appId = @"dmbsream";

- (id)init
{
    self = [super init];
    if(self)
    {
        keychain = [[KeychainItemWrapper alloc] initWithIdentifier:appId accessGroup:nil];
    }
    return self;
}

- (NSString*)username
{
    return [keychain objectForKey:(__bridge id)kSecAttrAccount];
}

- (void)setUsername:(NSString*)username
{
    [keychain setObject:username forKey:(__bridge id)kSecAttrAccount];
}

- (NSString*)token
{
    return [keychain objectForKey:(__bridge id)kSecAttrAccount];
}

- (void)setToken:(NSString*)username
{
    [keychain setObject:username forKey:(__bridge id)kSecAttrAccount];
}

- (void)reset
{
    [keychain resetKeychainItem];
}

@end
