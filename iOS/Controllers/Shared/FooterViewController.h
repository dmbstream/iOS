//
//  FooterViewController.h
//  iOS
//
//  Created by James Geurts on 5/5/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FooterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *songTitle;
@property (weak, nonatomic) IBOutlet UILabel *artistAndVenueTitle;

- (IBAction)togglePlay:(id)sender;
- (IBAction)showExpandedPlayer:(id)sender;

- (void)refreshPlayPauseButton;

@end
