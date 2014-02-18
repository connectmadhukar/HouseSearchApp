//
//  RefineSearch.h
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/17/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchPreferance.h"

@protocol RefineSearch <NSObject>

-(void)searchWithPreferance:(SearchPreferance *)searchPreferance;

@end
