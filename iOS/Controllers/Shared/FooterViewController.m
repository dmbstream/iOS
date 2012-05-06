//
//  FooterViewController.m
//  iOS
//
//  Created by James Geurts on 5/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "FooterViewController.h"

@interface FooterViewController ()

@end

@implementation FooterViewController
@synthesize playButton;
@synthesize songTitle;
@synthesize artistAndVenueTitle;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPlayPauseButton) name:@"TogglePlay" object:nil];
}

- (void)viewDidUnload
{
    [self setPlayButton:nil];
    [self setPlayButton:nil];
    [self setSongTitle:nil];
    [self setArtistAndVenueTitle:nil];
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

- (IBAction)togglePlay:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TogglePlay" object:self];
}

- (IBAction)showExpandedPlayer:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowExpandedPlayer" object:self];
}

- (void)refreshPlayPauseButton {
    NSLog(@"refreshPlayPauseButton");
    UIImage *pauseImage = [UIImage imageNamed:@"toolbar_pause.png"];
    [self.playButton setImage:pauseImage forState:UIControlStateNormal];
}

@end
