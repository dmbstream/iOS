//
//  HeaderViewController.h
//  iOS
//
//  Created by James Geurts on 5/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)search:(id)sender;
- (IBAction)backToRootView:(id)sender;

- (void)showActivityIndicator;
- (void)hideActivityIndicator;

@end
