//
//  AppDelegate.h
//  iOS
//
//  Created by James Geurts on 4/27/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (atomic) int *netActivityReqs;

-(void) requestNetworkActivityIndicator;
-(void) releaseNetworkActivityIndicator;

@end
