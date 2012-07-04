//
//  ConcertDetailsViewController.m
//  iOS
//
//  Created by James Geurts on 7/3/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "ConcertDetailsViewController.h"

@interface ConcertDetailsViewController ()

@end

@implementation ConcertDetailsViewController
@synthesize concertId;
@synthesize artist;
@synthesize date;
@synthesize venue;
@synthesize trackList;

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
    [self setArtist:nil];
    [self setDate:nil];
    [self setVenue:nil];
    [self setTrackList:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
    super.scrollView.hidden = YES;
    
    // Show loading spinner
    [super showActivityIndicator];
    
    // Get concert details
    if (self.concertId == CONCERT_RANDOM_ID) {
        
    } else {
        
    }    
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear");
    
    // Hide loading spinner
    [super hideActivityIndicator];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)playAll:(id)sender {
}

- (IBAction)queueAll:(id)sender {
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
