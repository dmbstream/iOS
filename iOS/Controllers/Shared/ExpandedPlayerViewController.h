//
//  ExpandedPlayerViewController.h
//  iOS
//
//  Created by James Geurts on 5/1/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandedPlayerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    BOOL isEditing;
}

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *artistAndVenue;
@property (weak, nonatomic) IBOutlet UITableView *trackList;
@property (weak, nonatomic) IBOutlet UISlider *seekSlider;
@property (weak, nonatomic) IBOutlet UILabel *currentPosition;
@property (weak, nonatomic) IBOutlet UILabel *trackLength;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftToolbarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightToolbarButton;

- (IBAction)leftToolbarAction:(id)sender;
- (IBAction)rightToolbarAction:(id)sender;
- (IBAction)seek:(id)sender;
- (IBAction)togglePlay:(id)sender;
- (IBAction)fastForward:(id)sender;
- (IBAction)rewind:(id)sender;


@end
