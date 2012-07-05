//
//  UITextField+Validation.m
//  iOS
//
//  Created by James Geurts on 5/13/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "UITextField+Validation.h"

@implementation UITextField (UITextField_Validation)

- (BOOL)requiredText
{
    if([self.text length] > 0)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)validateRegEx:(NSString*)regexString
{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:self.text
                                                        options:0
                                                          range:NSMakeRange(0, [self.text length])];
    
    return numberOfMatches > 0;
    
}

- (BOOL)validZipCode
{
    return [self validateRegEx:@"^\\d{5}([\\-]\\d{4})?$"];
}

- (BOOL)validPhoneNumber
{
    return [self validateRegEx:@"^[01]?[- .]?\\(?[2-9]\\d{2}\\)?[- .]?\\d{3}[- .]?\\d{4}$"];
}

- (BOOL)validEmailAddress
{
    return [self validateRegEx:@"^[A-Z0-9a-z._%\\+\\-]+@[A-Za-z0-9\\.\\-]+\\.[A-Za-z]{2,4}$"];
}

- (BOOL)validPassword
{
    if([self.text length] > 5)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)validUsername
{
    if([self.text length] > 2)
    {
        return YES;
    }
    
    return NO;
}

@end