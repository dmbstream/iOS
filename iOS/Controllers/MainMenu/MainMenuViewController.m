//
//  MainMenuViewController.m
//  iOS
//
//  Created by James Geurts on 5/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ChatViewController.h"
#import "LatestAddedConcertsViewController.h"
#import "LatestPerformedConcertsViewController.h"
#import "YourFavoritesViewController.h"
#import "YourPlaylistsViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

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

- (IBAction)chat:(id)sender {
    ChatViewController *controller = [[ChatViewController alloc] init];
    controller.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)latestAddedConcerts:(id)sender {
    LatestAddedConcertsViewController *controller = [[LatestAddedConcertsViewController alloc] init];
    controller.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)latestPerformedConcerts:(id)sender {
    LatestPerformedConcertsViewController *controller = [[LatestPerformedConcertsViewController alloc] init];
    controller.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)search:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchViewRequested" object:self];
}

- (IBAction)randomConcert:(id)sender {
}

- (IBAction)yourFavorites:(id)sender {
    YourFavoritesViewController *controller = [[YourFavoritesViewController alloc] init];
    controller.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)yourPlaylists:(id)sender {
    YourPlaylistsViewController *controller = [[YourPlaylistsViewController alloc] init];
    controller.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:controller animated:YES];
}
@end
