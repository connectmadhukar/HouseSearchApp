//
//  HomeDetailsViewController.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/2/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "HomeDetailsViewController.h"
#import "AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "HouseConfigs.h"
#import "FavHouse.h"

@interface HomeDetailsViewController ()


@end

@implementation HomeDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgNumber = 0;
    self.houseNameLabel.text = self.house.propName;
    [self.houseNameLabel sizeToFit];
    self.propertyFeaturesTable.delegate = self;
    self.propertyFeaturesTable.dataSource = self;
    [self.propertyFeaturesTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.propertyFeaturesTable.layer.borderWidth = 2;
    self.propertyFeaturesTable.layer.borderColor = [[UIColor purpleColor] CGColor];

    self.propertyConfigsTable.delegate = self;
    self.propertyConfigsTable.dataSource = self;
    [self.propertyConfigsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ConfigCell"];
    self.propertyConfigsTable.layer.borderWidth = 2;
    self.propertyConfigsTable.layer.borderColor = [[UIColor purpleColor] CGColor];
    
    
    UIImage *image = [UIImage imageNamed: @"homeDeafult.jpeg"];
    [self.houseBImageView setImage:image];
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self.house.latitude doubleValue];
    coordinate.longitude = [self.house.longitude doubleValue];
    
    MKPlacemark *mPlacemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil] ;
   [self.houseLocationMapView addAnnotation:mPlacemark];

    MKCoordinateRegion region;
    region.center.latitude = [self.house.latitude doubleValue];
    region.center.longitude = [self.house.longitude doubleValue];
    region.span.latitudeDelta = 0.05;
    region.span.longitudeDelta = 0.05;
    [self.houseLocationMapView setRegion:region animated:YES];
    
    if(self.house.images.count != 0 ) {
        [self fetchImage:[NSURL URLWithString:[self.house.images objectAtIndex:0]] imageViewToLoadInto:self.houseBImageView];
    }
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(homeImageViewTapped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.houseBImageView addGestureRecognizer:singleTap];
    [self.houseBImageView setUserInteractionEnabled:YES];
    
    [self findFavHouse];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.propertyFeaturesTable) {
        return self.house.features.count;
    } else {
        return self.house.propertyConfigs.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (tableView == self.propertyFeaturesTable) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        cell.textLabel.text = [self.house.features objectAtIndex:[indexPath row]];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ConfigCell"];
        HouseConfigs *houseCfg = [self.house.propertyConfigs objectAtIndex:[indexPath row]];
        NSString *cfgString = [NSString stringWithFormat:@"%@ - %@ sft - $%@", houseCfg.bedrooms, houseCfg.sqFt, houseCfg.rent];
        cell.textLabel.text = cfgString;
    }
    cell.textLabel.font = [UIFont fontWithName:@"ArialMT" size:9];
    return cell;
}

- (void) fetchImage:(NSURL *)imageUrl imageViewToLoadInto:(UIImageView *) imageView{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.color = [UIColor redColor];
    CGRect rect = [imageView frame];
    rect.origin.y =0;
 //   NSLog(@" rect:%@", NSStringFromCGRect(rect));
    activityIndicator.frame = rect;
    [activityIndicator startAnimating];
    [imageView addSubview:activityIndicator];
    imageView.userInteractionEnabled = NO;
    
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:imageUrl];
    AFHTTPRequestOperation *postOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlReq];
    postOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [postOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"Response: %@", imageUrl);
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
        imageView.userInteractionEnabled = YES;
        imageView.image = responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    [postOperation start];
}

- (IBAction)homeImageViewTapped:(UITapGestureRecognizer *)sender {
    //NSLog(@"Location in View: %@", NSStringFromCGPoint([sender locationInView:self.houseBImageView]));
    
    //NSLog(@"self.house.images.count:%d self.imgNumber:%d", self.house.images.count , self.imgNumber);
    if(self.house.images.count != 0 && self.house.images.count != 1) {
        NSInteger tchX = [sender locationInView:self.houseBImageView].x;
        NSInteger ivCtrX = [self.houseBImageView center].x;
        if( tchX < ivCtrX ) {
          self.imgNumber = (self.imgNumber + self.house.images.count - 1 )% self.house.images.count;
        } else {
          self.imgNumber = (self.imgNumber +1 )% self.house.images.count;
        }
        //NSLog(@"self.house.images.count:%d self.imgNumber:%d", self.house.images.count , self.imgNumber);
        
        [self fetchImage:[NSURL URLWithString:[self.house.images objectAtIndex:self.imgNumber]] imageViewToLoadInto:self.houseBImageView];
    }
}
- (IBAction)markOrUnMarkFav:(id)sender {
    NSLog(@" markOrUnMarkFav Button Pressed");
    [self.markFavBtn setUserInteractionEnabled:NO];
    if(self.markFavBtn.selected) {
        [self.favHouse deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded) {
                
            } else {
                self.markFavBtn.selected = true;
                NSLog(@"error");
            }
            [self.markFavBtn setUserInteractionEnabled:YES];
        }];
        self.markFavBtn.selected = false;
    } else {
        FavHouse *favHouse = [FavHouse object];
        [favHouse initFromHouse:self.house];
        favHouse[@"user"] = [PFUser currentUser];
        [favHouse saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded) {
                NSLog(@"succeeded");
                [self findFavHouse];
            } else {
                self.markFavBtn.selected = false;
                NSLog(@"error");
            }
            [self.markFavBtn setUserInteractionEnabled:YES];
        }];
        self.markFavBtn.selected = true;
    }
}

- (void) findFavHouse {
    PFQuery *query = [FavHouse query];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query whereKey:@"propName" equalTo:self.house.propName];
    [query whereKey:@"address" equalTo:self.house.address];
    [query whereKey:@"city" equalTo:self.house.city];
    [query whereKey:@"zipCode" equalTo:self.house.zipCode];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && [objects count]>0) {
            self.markFavBtn.selected = true;
            self.favHouse = objects[0];
        } else {
            self.markFavBtn.selected = false;
        }
    }];
}
@end
