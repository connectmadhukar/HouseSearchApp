//
//  HouseConfigs.h
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/23/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "HouseConfigs.h"


@interface FavHouseConfigs : PFObject<PFSubclassing>

@property (retain, nonatomic, strong) NSString *bedrooms;
@property (retain, nonatomic, strong) NSString *fullBathrooms;
@property (retain, nonatomic, strong) NSString *partialBathrooms;
@property (retain, nonatomic, strong) NSString *sqFt;
@property (retain, nonatomic, strong) NSString *rent;
@property (retain, nonatomic, strong) NSString *rentPostedDate ;

- (void)initFromHouseConfigs:(HouseConfigs *) houseConfigs;
+ (NSString *)parseClassName;

@end
