//
//  ConcertDetailsViewController.h
//  iOS
//
//  Created by James Geurts on 7/3/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ConcertDetailsViewController : BaseViewController

@property(nonatomic) NSString *concertId;

@property (weak, nonatomic) IBOutlet UILabel *artist;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *venue;
@property (weak, nonatomic) IBOutlet UITableView *trackList;

- (IBAction)playAll:(id)sender;
- (IBAction)queueAll:(id)sender;

- (IBAction)back:(id)sender;

@end
