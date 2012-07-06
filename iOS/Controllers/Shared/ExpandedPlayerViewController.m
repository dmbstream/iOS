//
//  ExpandedPlayerViewController.m
//  iOS
//
//  Created by James Geurts on 5/1/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "ExpandedPlayerViewController.h"
#import "TrackCell.h"
#import "Track.h"

@interface ExpandedPlayerViewController ()

@end

@implementation ExpandedPlayerViewController
@synthesize name;
@synthesize artistAndVenue;
@synthesize trackList;
@synthesize seekSlider;
@synthesize currentPosition;
@synthesize trackLength;
@synthesize leftToolbarButton;
@synthesize rightToolbarButton;

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
    [self setTrackList:nil];
    [self setName:nil];
    [self setArtistAndVenue:nil];
    [self setSeekSlider:nil];
    [self setCurrentPosition:nil];
    [self setTrackLength:nil];
    [self setLeftToolbarButton:nil];
    [self setRightToolbarButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)leftToolbarAction:(id)sender {
    if (isEditing) {
        NSLog(@"Clearing all queue items");
        // TODO: Clear all items from the playlist
        [trackList reloadData];
    } else {
        [self dismissModalViewControllerAnimated:YES];        
    }
}

- (IBAction)rightToolbarAction:(id)sender {
    NSLog(@"edit track list");
    if (isEditing) {
        [trackList setEditing:NO animated:YES];
        [leftToolbarButton setTitle:@"Done"];
        [rightToolbarButton setTitle:@"Edit"];
    } else {
        [trackList setEditing:YES animated:YES];
        [leftToolbarButton setTitle:@"Clear All"];
        [rightToolbarButton setTitle:@"Done"];
    }
    isEditing = !isEditing;
}

- (IBAction)togglePlay:(id)sender {
    NSLog(@"togglePlay");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TogglePlay" object:self];
}

- (IBAction)seek:(id)sender {
    NSLog(@"seek");
}

- (IBAction)fastForward:(id)sender {
    NSLog(@"fastForward");
}

- (IBAction)rewind:(id)sender {
    NSLog(@"rewind");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
                cell.showsReorderControl = YES;
                break;  
            }
        }
    }
    
    // TODO: set cell properties
    cell.name.text = @"Sample";
    cell.duration.text = @"12:23";
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Send event to play that song
    
    [trackList deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"commitEditingStyle - for:%d", indexPath.row);
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // TODO: Delete the item from the array.
        
        [tableView reloadData];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"moveRowAtIndexPath - from:%d to:%d", sourceIndexPath.row, destinationIndexPath.row);
    /*    id thing = [things objectAtIndex:sourceIndexPath.row];
     [things removeObjectAtIndex:sourceIndexPath.row];
     [things insertObject:thing atIndex:destinationIndexPath.row];
     */
}

@end
