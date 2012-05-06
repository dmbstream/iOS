//
//  BaseViewController.m
//  iOS
//
//  Created by James Geurts on 5/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "BaseViewController.h"
#import "SearchViewController.h"
#import "ExpandedPlayerViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize managedObjectContext;

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
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigateToRootView) name:@"RootViewRequested" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(navigateToSearchView) name:@"SearchViewRequested" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showExpandedPlayerView) name:@"ShowExpandedPlayer" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(togglePlay) name:@"TogglePlay" object:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Methods

- (void)navigateToRootView {
    NSLog(@"navigateToRootView");
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)navigateToSearchView {
    NSLog(@"navigateToSearchView");
    
    SearchViewController *searchController = [[SearchViewController alloc] init];
    searchController.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:searchController animated:YES];
}
- (void)showExpandedPlayerView {
    NSLog(@"showExpandedPlayerView");
    
    ExpandedPlayerViewController *expandedPlayerController = [[ExpandedPlayerViewController alloc] init];
    
    [self presentModalViewController:expandedPlayerController animated:YES];
}
- (void)togglePlay {
    NSLog(@"togglePlay");
}

@end
