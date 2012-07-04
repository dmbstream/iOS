//
//  ConcertDetailsViewController.m
//  iOS
//
//  Created by James Geurts on 7/3/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "ConcertDetailsViewController.h"
#import "ConcertService.h"
#import "Concert.h"

@interface ConcertDetailsViewController ()

@end

@implementation ConcertDetailsViewController
@synthesize concertId;
@synthesize title;
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
    [self setTitle:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
    super.scrollView.hidden = YES;
    
    // Show loading spinner
    [super showActivityIndicator];

    ConcertService *service = [ConcertService new];

    [service getConcert:concertId completionHandler:^(Concert* concert, NSError* error) {
        if (error) {
            NSMutableString *message = [[NSMutableString alloc] initWithString: @"There was a problem getting the concert details.  Please try again."];
            //                [message appendString:[error localizedDescription]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
            
            NSLog(@"%@", error);
        } else {
            NSLog(@"%@", concert);
            
            
            NSDateFormatter *titleFormatter = [[NSDateFormatter alloc] init];
            [titleFormatter setDateFormat:@"yyyy-MM-dd"];
            
            
            [title setText:[NSString stringWithFormat:@"%@ :: %@", [titleFormatter stringFromDate:concert.date], concert.name]];            
            [artist setText:concert.artist.name];
            [venue setText:concert.venue.name];

            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterLongStyle];
            [formatter setTimeStyle:NSDateFormatterNoStyle];
            [date setText:[formatter stringFromDate:concert.date]];
            
            super.scrollView.hidden = NO;
        }
        [super hideActivityIndicator];
    }];    
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
