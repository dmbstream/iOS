//
//  LatestAddedConcertsViewController.m
//  iOS
//
//  Created by James Geurts on 5/4/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "LatestAddedConcertsViewController.h"
#import "ConcertService.h"
#import "ConcertCell.h"
#import "NSDate+Strings.h"
#import "ConcertDetailsViewController.h"

@interface LatestAddedConcertsViewController ()

@end

@implementation LatestAddedConcertsViewController
@synthesize concertList;

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
    [self setConcertList:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"viewWillAppear");
    
    // If we have just shown this concert, no need to reload it from the site
    if (hasLoaded)
        return;
    
    // Show loading spinner
    [super showActivityIndicator];
    
    ConcertService *service = [ConcertService new];
    
    [service getLatestAdded:^(NSArray* items, NSError* error) {
        if (error) {
            NSMutableString *message = [[NSMutableString alloc] initWithString: @"There was a problem getting the list of concerts.  Please try again."];
            //                [message appendString:[error localizedDescription]];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alertView show];
            
            NSLog(@"%@", error);
        } else {
            
            concerts = items;
            [concertList reloadData];

            hasLoaded = true;
        }
        [super hideActivityIndicator];
    }];      
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return [concerts count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ConcertCell";
    ConcertCell *cell = (ConcertCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"ConcertCell" owner:nil options:nil];
        
        for(id currentNibObject in nibObjects)
        {
            if ([currentNibObject isKindOfClass:[UITableViewCell class]]) {
                cell = (ConcertCell*)currentNibObject;
                break;  
            }
        }
    }
    
    Concert *concert = (Concert*)[concerts objectAtIndex:indexPath.row];
    
    cell.name.text = concert.name;
    cell.artist.text = concert.artist.abbreviation;
    cell.date.text = [concert.date toShortDateString];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Concert *concert = (Concert*)[concerts objectAtIndex:indexPath.row];
    
    NSLog(@"Selected concert: %@", concert);
    
    [concertList deselectRowAtIndexPath:indexPath animated:YES];
    
    ConcertDetailsViewController *controller = [[ConcertDetailsViewController alloc] init];
    controller.managedObjectContext = self.managedObjectContext;
    controller.concertId = concert.id;
    
    [self.navigationController pushViewController:controller animated:YES];    
}

@end
