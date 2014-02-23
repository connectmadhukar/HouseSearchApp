//
//  HouseConfigs.h
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/23/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HouseConfigs : NSObject

@property (nonatomic, strong) NSString *bedrooms;
@property (nonatomic, strong) NSString *fullBathrooms;
@property (nonatomic, strong) NSString *partialBathrooms;
@property (nonatomic, strong) NSString *sqFt;
@property (nonatomic, strong) NSString *rent;
@property (nonatomic, strong) NSString *rentPostedDate ;

- (id)initWithDictionary:(NSDictionary *) dictionary;

@end
