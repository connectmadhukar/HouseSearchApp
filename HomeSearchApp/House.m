//
//  House.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/2/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "House.h"
#import "HouseConfigs.h"

@implementation House


- (id)initWithDictionary:(NSDictionary *) dictionary {
    self.propName = [dictionary objectForKey:@"name"];

    self.address = [dictionary objectForKey:@"address"];
    if ( self.propName == (id)[NSNull null] || self.propName.length == 0) {
        self.propName = self.address;
    }
    self.city = [dictionary objectForKey:@"city"];
    self.zipCode = [dictionary objectForKey:@"zip_code"];
    self.state = [dictionary objectForKey:@"state"];
    NSArray *features = [dictionary objectForKey:@"features"];
    self.features = [NSMutableArray array];
    for (int i = 0; i < features.count; i++) {
        [self.features addObject:features[i]];
    }
    
    NSArray *images = [dictionary objectForKey:@"images"];
    self.images = [NSMutableArray array];
    for (int i = 0; i < images.count; i++) {
        NSString *url = [images[i] objectForKey:@"url"];
        [self.images addObject: url];
    }
    //NSLog(@"Images count: %d", self.images.count);
    self.latitude = [dictionary objectForKey:@"latitude"];
    self.longitude  = [dictionary objectForKey:@"longitude"];
    self.distanceFromQueryPoint  = [dictionary objectForKey:@"distance_mi"];
    
    // NSArray *housesJsonArray = [object valueForKeyPath:@"collection"];
    NSArray *propCfgsJsonArray = [dictionary objectForKey:@"latest_prices"];
    self.propertyConfigs = [NSMutableArray array];
    for (int i = 0; i < propCfgsJsonArray.count; i++) {
        NSDictionary *houseCfgsDict = [propCfgsJsonArray objectAtIndex:i];
        HouseConfigs *houseCfg = [[HouseConfigs alloc] initWithDictionary:houseCfgsDict];
        [self.propertyConfigs addObject:houseCfg];
    }
    return self;
}

@end
