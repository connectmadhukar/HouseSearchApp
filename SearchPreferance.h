//
//  SearcPreference.h
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/16/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import <Parse/Parse.h>

@interface SearchPreferance : PFObject<PFSubclassing>
+ (NSString *)parseClassName;
@property (retain) PFUser *user;
@property (retain) NSString *address;
@property (retain) NSString *distance;
@property               int bathRooms;
@property               int bedRooms;


@end
