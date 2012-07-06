//
//  LatestAddedConcertsViewController.h
//  iOS
//
//  Created by James Geurts on 5/4/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LatestAddedConcertsViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>
{
    BOOL hasLoaded;
    NSArray *concerts;
}

@property (weak, nonatomic) IBOutlet UITableView *concertList;

- (IBAction)back:(id)sender;

@end
