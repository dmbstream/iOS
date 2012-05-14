//
//  NSDataAdditions.h
//  iOS
//
//  Created by James Geurts on 5/11/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//
// From: http://colloquy.info/project/browser/trunk/Additions/NSDataAdditions.h

@interface NSData (NSDataAdditions)
+ (NSData *) dataWithBase64EncodedString:(NSString *) string;
- (id) initWithBase64EncodedString:(NSString *) string;

- (NSString *) base64Encoding;
- (NSString *) base64EncodingWithLineLength:(NSUInteger) lineLength;

- (BOOL) hasPrefixBytes:(const void *) prefix length:(NSUInteger) length;
- (BOOL) hasSuffixBytes:(const void *) suffix length:(NSUInteger) length;
@end
