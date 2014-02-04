//
//  HomeDetailsViewController.h
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/2/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "House.h"

@interface HomeDetailsViewController : UIViewController
@property (nonatomic, strong) House *house;

@property (weak, nonatomic) IBOutlet UILabel *houseNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *houseBImageView;
@property (weak, nonatomic) IBOutlet UITextView *houseFeaturesTextView;
//@property (weak, nonatomic) IBOutlet MKMapView *houseLocationMapView;

@end
