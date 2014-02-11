//
//  HomeDetailsViewController.h
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/2/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "House.h"
#import <MapKit/MapKit.h>

@interface HomeDetailsViewController : UIViewController
@property (nonatomic, strong) House *house;
- (IBAction)homeImageViewTapped:(UITapGestureRecognizer *)sender;

@property (weak, nonatomic) IBOutlet UILabel *houseNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *houseBImageView;
@property (weak, nonatomic) IBOutlet UITextView *houseFeaturesTextView;
@property (nonatomic) int imgNumber;

@property (weak, nonatomic) IBOutlet MKMapView *houseLocationMapView;

@end
