//
//  House.h
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/2/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface House : NSObject

@property (nonatomic, strong) NSString *propName;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *zipCode;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSMutableArray *features;
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSString *latitude ;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *distanceFromQueryPoint;
@property (nonatomic, strong) NSMutableArray *propertyConfigs;

- (id)initWithDictionary:(NSDictionary *) dictionary;

@end
