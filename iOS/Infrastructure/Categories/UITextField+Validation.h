//
//  UITextField+Validation.h
//  iOS
//
//  Created by James Geurts on 5/13/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UITextField (UITextField_Validation)

- (BOOL)requiredText;
- (BOOL)validZipCode;
- (BOOL)validPhoneNumber;
- (BOOL)validEmailAddress;
- (BOOL)validUsername;
- (BOOL)validPassword;

@end
