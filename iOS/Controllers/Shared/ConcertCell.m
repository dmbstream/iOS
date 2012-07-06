//
//  ConcertCell.m
//  iOS
//
//  Created by James Geurts on 7/6/12.
//  Copyright (c) 2012 Bia Creations. All rights reserved.
//

#import "ConcertCell.h"

@implementation ConcertCell

@synthesize name,
            date,
            artist;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
