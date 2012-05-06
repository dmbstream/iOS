//
//  BaseViewController.h
//  iOS
//
//  Created by James Geurts on 5/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (void)navigateToRootView;
- (void)navigateToSearchView;
- (void)showExpandedPlayerView;
- (void)togglePlay;

@end
