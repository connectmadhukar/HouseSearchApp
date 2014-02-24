//
//  House.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/2/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "FavHouse.h"
#import <Parse/PFObject+Subclass.h>
#import "FavHouseConfigs.h"

@implementation FavHouse

@dynamic user;
@dynamic propName;
@dynamic address;
@dynamic city;
@dynamic zipCode;
@dynamic state;
@dynamic features;
@dynamic images;
@dynamic latitude ;
@dynamic longitude;
@dynamic distanceFromQueryPoint;
@dynamic propertyConfigs;

- (void)initFromHouse:(House *) house {
    self.propName = house.propName;

    self.address = house.address;
    self.city = house.city;
    self.zipCode = house.zipCode;
    self.state = house.state;
    self.features = [NSMutableArray arrayWithArray:house.features];
    self.images = [NSMutableArray arrayWithArray:house.images];

    self.latitude = house.latitude;
    self.longitude  = house.longitude;
    self.distanceFromQueryPoint  = house.distanceFromQueryPoint;
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < house.propertyConfigs.count; i++) {
        FavHouseConfigs *hsCfg = [FavHouseConfigs object];
        [hsCfg initFromHouseConfigs:[house.propertyConfigs objectAtIndex:i]];
        //NSLog(@" hscfg:%@ %@", hsCfg, [house.propertyConfigs objectAtIndex:i] );
        [temp addObject:hsCfg];
    }
    
    self.propertyConfigs = temp;//[NSArray arrayWithArray:temp];
}

+ (NSString *)parseClassName {
    return @"FavHouse";
}

@end
