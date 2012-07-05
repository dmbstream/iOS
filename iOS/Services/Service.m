//
//  Service.m
//  iOS
//
//  Created by James Geurts on 5/6/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "Service.h"
#import "NSDataAdditions.h"

@implementation Service

- (void)performRequest:(NSString*) url httpMethod:(NSString*)httpMethod username:(NSString*)username password:(NSString*)password params:(NSDictionary *)params convertHandler:(id (^)(NSDictionary*))convertHandler completionHandler:(void (^)(id, NSError *))completionHandler
{
    
    // Generate the URL
    NSString *requestUrl = [NSString stringWithFormat:@"http://dmbstream.com/api/%@", url];
    
    // Get the application api key
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"AppSettings" ofType:@"plist"];
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    
    // Create the connection
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestUrl]];
    [request setHTTPMethod:httpMethod];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[settings objectForKey:@"ApiKey"] forHTTPHeaderField:@"X-ApiKey"];
    [request setValue:[NSString stringWithFormat:@"iOS v%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]] forHTTPHeaderField:@"User-Agent"];
    
    if (params != nil) {
        NSError *error;
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
        
        // If there was an error encoding the JSON
        if (error) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completionHandler(nil, error);
            });
            return;
        }
        
        [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];        
        [request setHTTPBody: requestData];
    }

    // Add in authentication header
    if (username != nil) 
    {
        NSString *authString = [[[NSString stringWithFormat:@"%@:%@", username, password] dataUsingEncoding:NSUTF8StringEncoding] base64Encoding];        
        [request setValue:[NSString stringWithFormat:@"Basic %@", authString] forHTTPHeaderField:@"Authorization"];
    }
    
    // Make an NSOperationQueue
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue setName:url];
    
    // Send an asyncronous request on the queue
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        // If there was an error getting the data
        if (error) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completionHandler(nil, error);
            });
            return;
        }
        
        // Decode the data
        NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        
        // If there was an error decoding the JSON
        if (error) {
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completionHandler(nil, error);
            });
            return;
        }
        
        
        // Check for a non 200 response and throw it as an error
        if ([responseDict objectForKey:@"error_message"] && [(NSString*)[responseDict valueForKey:@"error_message"] length] > 0) {
            NSLog(@"%@", responseDict);
            
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            [errorDetail setValue:[responseDict valueForKey:@"error_message"] forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"ios" code:100 userInfo:errorDetail];

            dispatch_async(dispatch_get_main_queue(), ^(void) {
                completionHandler(nil, error);
            });
            return;
        }
        
        // Get a model object type, rather than dealing with the NSDictionary
        id resultObject = convertHandler(responseDict);
        
        // All looks fine, lets call the completion block with the response data
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            completionHandler(resultObject, nil);
        });
    }];
}

@end