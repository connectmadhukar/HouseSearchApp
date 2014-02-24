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

@interface HomeDetailsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) House *house;

@property (weak, nonatomic) IBOutlet UILabel *houseNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *houseBImageView;
@property (weak, nonatomic) IBOutlet UITableView *propertyFeaturesTable;

@property (weak, nonatomic) IBOutlet MKMapView *houseLocationMapView;
@property (weak, nonatomic) IBOutlet UITableView *propertyConfigsTable;
@property (weak, nonatomic) IBOutlet UIButton *markFavBtn;
- (IBAction)markOrUnMarkFav:(id)sender;

@property (nonatomic) int imgNumber;

@end
