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
#import "LoginManager.h"
#import "LoginViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController
@synthesize welcomeLabel;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWelcomeText) name:EVENT_LOGGED_IN object:nil];

	[self refreshWelcomeText];
}

- (void)viewDidUnload
{
    [self setWelcomeLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Events

- (void)refreshWelcomeText {
    NSLog(@"refreshWelcomeText");
    
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:USER_NAME];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:LOGGED_IN] && name != nil) {
        NSMutableString *welcome = [NSMutableString stringWithString:@"Welcome "];    
        [welcome appendString:name];
        [welcome appendString:@"!"];
        
        [welcomeLabel setText:welcome];
    }
 
}

#pragma mark Actions

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

- (IBAction)logout:(id)sender {
    LoginManager *manager = [[LoginManager alloc] init];
    [manager reset];
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:LOGGED_IN];

    LoginViewController *loginController = [[LoginViewController alloc] init];
    [self presentModalViewController:loginController animated:NO];
}
@end
