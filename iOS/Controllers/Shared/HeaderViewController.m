//
//  HeaderViewController.m
//  iOS
//
//  Created by James Geurts on 5/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "HeaderViewController.h"
#import "Constants.h"

@interface HeaderViewController ()

@end

@implementation HeaderViewController

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
@end
