//
//  HeaderViewController.m
//  iOS
//
//  Created by James Geurts on 5/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "HeaderViewController.h"
#import "AppDelegate.h"
#import "Constants.h"

@interface HeaderViewController ()

@end

@implementation HeaderViewController
@synthesize activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"header:viewdidload");
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
 
    [self setActivityIndicator:nil];    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showActivityIndicator) name:EVENT_ACTIVITY_SHOW object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideActivityIndicator) name:EVENT_ACTIVITY_HIDE object:nil];
}
- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_ACTIVITY_SHOW object:nil]; 
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_ACTIVITY_HIDE object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)search:(id)sender {
    NSLog(@"search button clicked");
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_NAV_SEARCH object:self];
}

- (IBAction)backToRootView:(id)sender {
    NSLog(@"home button clicked");
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_NAV_HOME object:self];
}

- (void)showActivityIndicator {
    self.activityIndicator.hidden = NO;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate requestNetworkActivityIndicator];
}
- (void)hideActivityIndicator {
    self.activityIndicator.hidden = YES;
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate releaseNetworkActivityIndicator];
}

@end
