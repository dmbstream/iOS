//
//  MainMenuViewController.h
//  iOS
//
//  Created by James Geurts on 5/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface MainMenuViewController : BaseViewController
- (IBAction)chat:(id)sender;
- (IBAction)latestAddedConcerts:(id)sender;
- (IBAction)latestPerformedConcerts:(id)sender;
- (IBAction)search:(id)sender;
- (IBAction)randomConcert:(id)sender;
- (IBAction)yourFavorites:(id)sender;
- (IBAction)yourPlaylists:(id)sender;

@end
