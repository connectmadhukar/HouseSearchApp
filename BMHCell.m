//
//  HouseCell.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/3/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "BMHCell.h"

@implementation BMHCell

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
