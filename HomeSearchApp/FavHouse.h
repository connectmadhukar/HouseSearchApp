//
//  House.h
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/2/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "House.h"

@interface FavHouse  : PFObject<PFSubclassing>
@property (retain) PFUser *user;
@property (retain, nonatomic, strong) NSString *propName;
@property (retain, nonatomic, strong) NSString *address;
@property (retain, nonatomic, strong) NSString *city;
@property (retain, nonatomic, strong) NSString *zipCode;
@property (retain, nonatomic, strong) NSString *state;
@property (retain, nonatomic, strong) NSMutableArray *features;
@property (retain, nonatomic, strong) NSMutableArray *images;
@property (retain, nonatomic, strong) NSString *latitude ;
@property (retain, nonatomic, strong) NSString *longitude;
@property (retain, nonatomic, strong) NSString *distanceFromQueryPoint;
@property (retain, nonatomic, strong) NSMutableArray *propertyConfigs;

- (void)initFromHouse:(House *) House;
+ (NSString *)parseClassName;

@end
