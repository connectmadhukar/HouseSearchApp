//
//  HomesListViewController.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/2/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "BMHListViewController.h"
#import "House.h"
#import "BMHCell.h"
#import "HomeDetailsViewController.h"
#import "RefineViewController.h"
#import <Parse/Parse.h>
#import "AFNetworking.h"
#import "SearchPreferance.h"
#import "HouseConfigs.h"
#import "FavHouseConfigs.h"
#import "House.h"
#import "FavHouse.h"



@interface BMHListViewController ()

@property (nonatomic, strong) NSMutableArray *houses;


@end

@implementation BMHListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
     NSLog(@"initWithStyle");
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"initWithCoder");
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.houses = [NSMutableArray array];
     }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    self.houses = [NSMutableArray array];
    [self fetchMoreData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Bookmarks"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.houses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"cellForRowAtIndexPath");
    FavHouse *house = [self.houses objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"BMHCell";
    
    BMHCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[BMHCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.propName.text = house.propName;
    cell.addressLabel.text = house.address;
    [cell.addressLabel sizeToFit];
    cell.cityLabel.text = house.city;
    [cell.cityLabel sizeToFit];
    cell.zipCodeLabel.text = house.zipCode;
    [cell.zipCodeLabel sizeToFit];
    cell.stateLabel.text = house.state;
    [cell.stateLabel sizeToFit];
    UIImage *image = [UIImage imageNamed: @"homeDeafult.jpeg"];
    [cell.houseImageView setImage:image];
    if(house.images.count != 0 ) {
        [self fetchImage:[NSURL URLWithString:[house.images objectAtIndex:0]] imageViewToLoadInto:cell.houseImageView];
    }
    return cell;
}


- (void) fetchImage:(NSURL *)imageUrl imageViewToLoadInto:(UIImageView *) imageView{

    NSURLRequest *urlReq = [NSURLRequest requestWithURL:imageUrl];
    AFHTTPRequestOperation *postOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlReq];
    postOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [postOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"Response: %@", responseObject);

        imageView.image = responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    [postOperation start];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //NSLog(@"id: %@", segue.identifier);
    UITableViewCell *selectedCell = (UITableViewCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
    FavHouse *favHouse = self.houses[indexPath.row];
    House *house = [self favHouseToHouse:favHouse];
    HomeDetailsViewController *homeDetailsViewController = (HomeDetailsViewController *)segue.destinationViewController;
    homeDetailsViewController.house = house;
}

- (void) fetchMoreData {
    
    UIActivityIndicatorView *activityIndicator ;
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.color = [UIColor redColor];
    CGRect rect = [self.view frame];
    rect.origin.y =0;
        
    activityIndicator.frame = rect;
    [activityIndicator startAnimating];
    [self.view addSubview:activityIndicator];
    self.view.userInteractionEnabled = NO;
   
    PFQuery *query = [FavHouse query];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query includeKey:@"propertyConfigs"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && [objects count]>0) {
            for(int i = 0; i < objects.count; i++) {
                FavHouse *favHouse = objects[i];
                NSLog(@"favHouse: %@", favHouse);
                [self.houses addObject:favHouse];
            }
            [self.tableView reloadData];
        } else {
           // self.markFavBtn.selected = false;
        }
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
        self.view.userInteractionEnabled = YES;
    }];

 }

- (House *)favHouseToHouse:(FavHouse *) favHouse {
    House *tempHouse = [House alloc];
    tempHouse.propName = favHouse.propName;
    tempHouse.address = favHouse.address;
    tempHouse.city = favHouse.city;
    tempHouse.zipCode = favHouse.zipCode;
    tempHouse.state = favHouse.state;
    NSMutableArray *temp = [NSMutableArray array];
    for (int i = 0; i < favHouse.propertyConfigs.count; i++) {
        HouseConfigs *hsCfg = [self favHouseConfigsToHouseConfigs:[favHouse.propertyConfigs objectAtIndex:i]];
        [temp addObject:hsCfg];
    }
    tempHouse.propertyConfigs = temp;
    
    tempHouse.features = [NSMutableArray arrayWithArray:favHouse.features];
    tempHouse.images = [NSMutableArray arrayWithArray:favHouse.images];
    
    tempHouse.latitude = favHouse.latitude;
    tempHouse.longitude  = favHouse.longitude;
    tempHouse.distanceFromQueryPoint  = favHouse.distanceFromQueryPoint;
    return tempHouse;
}

- (HouseConfigs *) favHouseConfigsToHouseConfigs:(FavHouseConfigs *) favHouseConfigs {
    HouseConfigs *tmpHouseConfigs = [HouseConfigs alloc];
    tmpHouseConfigs.bedrooms = favHouseConfigs.bedrooms;
    
    tmpHouseConfigs.fullBathrooms = favHouseConfigs.fullBathrooms;
    tmpHouseConfigs.partialBathrooms = favHouseConfigs.partialBathrooms;
    tmpHouseConfigs.sqFt = favHouseConfigs.sqFt;
    tmpHouseConfigs.rent = favHouseConfigs.rent;
    tmpHouseConfigs.rentPostedDate = favHouseConfigs.rentPostedDate;
    return tmpHouseConfigs;
}

@end
