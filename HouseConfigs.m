//
//  HouseConfigs.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/23/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "HouseConfigs.h"

@implementation HouseConfigs
- (id)initWithDictionary:(NSDictionary *) dictionary {
    self.bedrooms = [dictionary objectForKey:@"bedrooms"];

    self.fullBathrooms = [dictionary objectForKey:@"full_bathrooms"];
    self.partialBathrooms = [dictionary objectForKey:@"partial_bathrooms"];
    self.sqFt = [dictionary objectForKey:@"sq_ft"];
    self.rent = [dictionary objectForKey:@"rent"];
    self.rentPostedDate = [dictionary objectForKey:@"rent_posted_date"];
    
    return self;
}

@end
