//
//  SearcPreference.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/16/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "SearchPreferance.h"
#import <Parse/PFObject+Subclass.h>

@implementation SearchPreferance
@dynamic user;
@dynamic address;
@dynamic distance;
@dynamic bathRooms;
@dynamic bedRooms;
+ (NSString *)parseClassName {
    return @"SearchPreferance";
}


@end
