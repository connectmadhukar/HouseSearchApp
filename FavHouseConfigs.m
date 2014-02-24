//
//  HouseConfigs.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/23/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "FavHouseConfigs.h"
#import <Parse/PFObject+Subclass.h>

@implementation FavHouseConfigs

@dynamic bedrooms;
@dynamic fullBathrooms;
@dynamic partialBathrooms;
@dynamic sqFt;
@dynamic rent;
@dynamic rentPostedDate ;


- (void)initFromHouseConfigs:(HouseConfigs *) houseConfigs {
    self[@"bedrooms"] = (houseConfigs.bedrooms == (id)[NSNull null])?@"0":houseConfigs.bedrooms;
    self.fullBathrooms = (houseConfigs.fullBathrooms == (id)[NSNull null])?@"0":houseConfigs.fullBathrooms;;
    self.partialBathrooms = (houseConfigs.partialBathrooms == (id)[NSNull null])?@"0":houseConfigs.partialBathrooms;;
    self.sqFt = (houseConfigs.sqFt == (id)[NSNull null])?@"0":houseConfigs.sqFt;;
    self.rent = (houseConfigs.rent == (id)[NSNull null])?@"0":houseConfigs.rent;;
    self.rentPostedDate = (houseConfigs.rentPostedDate == (id)[NSNull null])?@"0":houseConfigs.rentPostedDate;
}

+ (NSString *)parseClassName {
    return @"FavHouseConfigs";
}
@end
