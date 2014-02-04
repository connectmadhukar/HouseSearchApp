//
//  House.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/2/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "House.h"

@implementation House
- (id)initWithDictionary:(NSDictionary *) dictionary;
{
    self.name = [dictionary objectForKey:@"name"];

    self.address = [dictionary objectForKey:@"address"];
    if ( self.name == (id)[NSNull null] || self.name.length == 0) {
        self.name = self.address;
    }
    self.city = [dictionary objectForKey:@"city"];
    self.zipCode = [dictionary objectForKey:@"zip_code"];
    self.state = [dictionary objectForKey:@"state"];
    NSArray *features = [dictionary objectForKey:@"features"];
    self.features = [[NSMutableString alloc] init];
    for (int i = 0; i < features.count; i++) {
        NSString *name = features[i];
        if (i) {
            [self.features appendString:@"\n"];
        }
        [self.features appendString:name];
    }
    
    NSArray *images = [dictionary objectForKey:@"images"];
    self.images = [NSMutableArray array];
    for (int i = 0; i < images.count; i++) {
        NSURL *url = [NSURL URLWithString:(NSString *) [images[i] objectForKey:@"url"]];
        [self.images addObject: url];
    }
    //NSLog(@"Images count: %d", self.images.count);
    self.latitude = [dictionary objectForKey:@"latitude"];
    self.longitude  = [dictionary objectForKey:@"longitude"];
    self.distanceFromQueryPoint  = [dictionary objectForKey:@"distance_mi"];
    return self;
}

@end
