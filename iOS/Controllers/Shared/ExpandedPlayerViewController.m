//
//  ExpandedPlayerViewController.m
//  iOS
//
//  Created by James Geurts on 5/1/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "ExpandedPlayerViewController.h"

@interface ExpandedPlayerViewController ()

@end

@implementation ExpandedPlayerViewController

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

- (IBAction)done:(UIBarButtonItem *)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
