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
#import "Track.h"
#import "TrackCell.h"

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
    NSLog(@"viewDidLoad");
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
    
    // If we have just shown this concert, no need to reload it from the site
    if (concert != nil)
        return;
            
    super.scrollView.hidden = YES;
    
    // Show loading spinner
    [super showActivityIndicator];
    
    ConcertService *service = [ConcertService new];

    [service getConcert:concertId completionHandler:^(Concert* c, NSError* error) {
        if (error) {
            NSMutableString *message = [[NSMutableString alloc] initWithString: @"There was a problem getting the concert details.  Please try again."];
            //                [message appendString:[error localizedDescription]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
            
            NSLog(@"%@", error);
        } else {
            
            // Set the concert object so that we do not reload unnecessarily
            concert = c;
            // Make sure that we know the displayed concert id, if this was a random concert
            concertId = concert.id;
            
            NSDateFormatter *titleFormatter = [[NSDateFormatter alloc] init];
            [titleFormatter setDateFormat:@"yyyy-MM-dd"];
            
            
            [title setText:[NSString stringWithFormat:@"%@ :: %@", [titleFormatter stringFromDate:concert.date], concert.name]];            
            [artist setText:concert.artist.name];
            [venue setText:concert.venue.name];

            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateStyle:NSDateFormatterLongStyle];
            [formatter setTimeStyle:NSDateFormatterNoStyle];
            [date setText:[formatter stringFromDate:concert.date]];
            
            // Populate the track table now
            int trackRowHeight = [concert.tracks count] * 50;
            [trackList reloadData];
            trackList.frame = CGRectMake(trackList.frame.origin.x,
                                         trackList.frame.origin.y,
                                         trackList.frame.size.width, 
                                         trackRowHeight);

            CGRect scrollViewFrame = [super.scrollView frame];
            scrollViewFrame.size.height = trackList.frame.origin.x + 50 + trackRowHeight;
            
            super.scrollView.contentSize = scrollViewFrame.size;            
                        
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
        
#pragma mark - Table view data source
        
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [concert.tracks count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TrackCell *cell = (TrackCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"TrackCell" owner:nil options:nil];
        
        for(id currentNibObject in nibObjects)
        {
            if ([currentNibObject isKindOfClass:[UITableViewCell class]]) {
                cell = (TrackCell*)currentNibObject;
                break;  
            }
        }
    }
    
    Track *track = (Track*)[concert.tracks objectAtIndex:indexPath.row];
    
    cell.name.text = track.name;
    cell.duration.text = track.duration;
        
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Track *track = (Track*)[concert.tracks objectAtIndex:indexPath.row];
    
    NSLog(@"Selected track: %@", track);
    
    [trackList deselectRowAtIndexPath:indexPath animated:YES];
}

@end
