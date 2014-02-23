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

@interface HomeDetailsViewController ()


@end

@implementation HomeDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgNumber = 0;
    self.houseNameLabel.text = self.house.name;
    [self.houseNameLabel sizeToFit];
    self.propertyFeaturesTable.delegate = self;
    self.propertyFeaturesTable.dataSource = self;
    [self.propertyFeaturesTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.propertyFeaturesTable.layer.borderWidth = 2;
    self.propertyFeaturesTable.layer.borderColor = [[UIColor purpleColor] CGColor];

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
        [self fetchImage:[self.house.images objectAtIndex:0] imageViewToLoadInto:self.houseBImageView];
    }
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(homeImageViewTapped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.houseBImageView addGestureRecognizer:singleTap];
    [self.houseBImageView setUserInteractionEnabled:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.house.features.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.propertyFeaturesTable dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.font = [UIFont fontWithName:@"ArialMT" size:9];
    cell.textLabel.text = [self.house.features objectAtIndex:[indexPath row]];
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
    NSLog(@"Location in View: %@", NSStringFromCGPoint([sender locationInView:self.houseBImageView]));
    
    NSLog(@"self.house.images.count:%d self.imgNumber:%d", self.house.images.count , self.imgNumber);
    if(self.house.images.count != 0 && self.house.images.count != 1) {
        NSInteger tchX = [sender locationInView:self.houseBImageView].x;
        NSInteger ivCtrX = [self.houseBImageView center].x;
        if( tchX < ivCtrX ) {
          self.imgNumber = (self.imgNumber + self.house.images.count - 1 )% self.house.images.count;
        } else {
          self.imgNumber = (self.imgNumber +1 )% self.house.images.count;
        }
        NSLog(@"self.house.images.count:%d self.imgNumber:%d", self.house.images.count , self.imgNumber);
        
        [self fetchImage:[self.house.images objectAtIndex:self.imgNumber] imageViewToLoadInto:self.houseBImageView];
    }
}
@end
