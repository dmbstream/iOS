//
//  ContainerViewController.m
//  iOS
//
//  Created by James Geurts on 5/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "ContainerViewController.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController

@synthesize headerController,
            footerController,
            contentController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    CGRect windowFrame = CGRectMake(0, 0, 320, 460);
    self.view = [[UIView alloc] initWithFrame:windowFrame];
    
    CGRect bounds = self.view.bounds;
    
    self.headerController.view.frame = CGRectMake(0,
                                                  0,
                                                  headerController.view.frame.size.width,
                                                  headerController.view.frame.size.height);
    self.footerController.view.frame = CGRectMake(0,
                                                  bounds.size.height - footerController.view.frame.size.height,
                                                  footerController.view.frame.size.width,
                                                  footerController.view.frame.size.height);
    
    self.contentController.view.frame = CGRectMake(0,
                                                   headerController.view.frame.size.height,
                                                   bounds.size.width,
                                                   (bounds.size.height - headerController.view.frame.size.height - footerController.view.frame.size.height));

    [self addChildViewController:headerController];
    [self addChildViewController:contentController];
    [self addChildViewController:footerController];
    
    [self.view addSubview:headerController.view];
    [self.view addSubview:contentController.view];
    [self.view addSubview:footerController.view];
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

@end
