//
//  HomesListViewController.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/2/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "HomesListViewController.h"
#import "House.h"
#import "HouseCell.h"
#import "HomeDetailsViewController.h"
#import "RefineViewController.h"
#import <Parse/Parse.h>
#import "AFNetworking.h"
#import "SearchPreferance.h"
#import "HSLogInViewController.h"
#import "HSSignUpViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface HomesListViewController ()

@property (nonatomic, strong) NSMutableArray *houses;
@property (nonatomic, strong) NSArray *housesJsonArray;
@property (nonatomic) NSInteger start;
@property (nonatomic) Boolean reloadRequired;
@property (nonatomic) Boolean searchPreferanceChanged;
@property (nonatomic, strong) PFObject *searchPreferance;


- (void)logOutButtonTapAction;

@end

@implementation HomesListViewController

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
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[HSLogInViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        logInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton;
        // Create the sign up view controller
        
        PFSignUpViewController *signUpViewController = [[HSSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"initWithCoder");
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.houses = [NSMutableArray array];
        self.start = 0;
        self.reloadRequired = true;
        self.searchPreferanceChanged = true;
        //[self fetchMoreData];
     }
    return self;
}


- (void)viewWillAppear:(BOOL)animated {
    //NSLog(@"view will appear");
    if( !self.searchPreferanceChanged ||  ![PFUser currentUser]) {
        return;
    }
    
    PFQuery *query = [SearchPreferance query];
    [query includeKey:@"user"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && [objects count]>0) {
            self.searchPreferance = objects[0];
            NSLog(@"search Preferance:%@", self.searchPreferance);
            //[self fetchMoreData];
        } else {
            self.searchPreferance = [PFObject objectWithClassName:@"SearchPreferance"];
        }
        self.houses = [NSMutableArray array];
        self.start = 0;
        self.reloadRequired = true;
        [self fetchMoreData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(logOutButtonTapAction)];
    
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
    House *house = [self.houses objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"HouseCell";
    
    HouseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[HouseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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
    //UIImage *aiImage = [UIImage imageNamed: @"activityIndicator.gif"];
    [cell.houseImageView setImage:image];
    cell.houseImageView.layer.cornerRadius = 25.0;
    cell.houseImageView.layer.masksToBounds = YES;
    //[cell.houseImageView setImage:aiImage];
    if(house.images.count != 0 ) {
        [self fetchImage:[NSURL URLWithString:[house.images objectAtIndex:0]] imageViewToLoadInto:cell.houseImageView];
    }
    /*
    if(( self.houses.count - indexPath.row) < 5 ) {
        self.reloadRequired = false;
        [self fetchMoreData];
    }
     */
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
    if( segue.identifier != nil && [segue.identifier compare:@"GoToRefineSearch"] == 0) {
        RefineViewController *refineViewController = (RefineViewController *)segue.destinationViewController;
        refineViewController.delegate = self;
        return;
    } if( segue.identifier != nil && [segue.identifier compare:@"GoToBookmarks"] == 0) {
        NSLog(@"segue.destinationViewController class:%@",[segue.destinationViewController class]);
    } else {
    UITableViewCell *selectedCell = (UITableViewCell *)sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
    House *house = self.houses[indexPath.row];
    
    HomeDetailsViewController *homeDetailsViewController = (HomeDetailsViewController *)segue.destinationViewController;
    homeDetailsViewController.house = house;
    }
    
}


#pragma mark - PFSignUpViewControllerDelegate

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    NSLog(@"didLogInUser");
    [self dismissViewControllerAnimated:YES completion:NULL];
}
// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || !field.length) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Information", nil) message:NSLocalizedString(@"Make sure you fill out all of the information!", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}


#pragma mark - ()
- (void)logOutButtonTapAction {
    NSLog(@"log out clicked");
    [PFUser logOut];
    [self viewDidAppear:true];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    float bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
    if (bottomEdge >= scrollView.contentSize.height) {
        //NSLog(@"scrollViewDidEndDecelerating");
        self.reloadRequired = true;
        [self fetchMoreData];
    }
}


-(void)searchWithPreferance:(SearchPreferance *)searchPreferance {
    self.searchPreferance = searchPreferance;
    //NSLog(@"searchPreferanceChanged");
    self.searchPreferanceChanged = true;
    self.reloadRequired = true;
}

- (void) fetchMoreData {
    
    UIActivityIndicatorView *activityIndicator ;
    if( self.searchPreferanceChanged ) {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityIndicator.color = [UIColor redColor];
        CGRect rect = [self.tableView frame];
        rect.origin.y =0;
        
        activityIndicator.frame = rect;
        [activityIndicator startAnimating];
        [self.view addSubview:activityIndicator];
        self.view.userInteractionEnabled = NO;
    }

    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.rentmetrics.com/api/v1/apartments.json?address=Sunnyvale,CA&api_token=TEST&limit=10&include_images=true&offset=%d", self.start]];
    
    NSString *urlString =[NSString stringWithFormat:@"http://www.rentmetrics.com/api/v1/apartments.json?api_token=TEST&limit=10&include_images=true&offset=%d", self.start];

    if( self.searchPreferance[@"address"] != nil ) {
        urlString = [NSString stringWithFormat:@"%@%@%@", urlString, @"&address=", [self.searchPreferance[@"address"] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    }

    if( self.searchPreferance[@"distance"] != nil ) {
        urlString = [NSString stringWithFormat:@"%@%@%@", urlString, @"&max_distance_mi=", self.searchPreferance[@"distance"] ];
    }

    if( self.searchPreferance[@"bathRooms"] != nil ) {
        urlString = [NSString stringWithFormat:@"%@%@%@", urlString, @"&bathrooms=", self.searchPreferance[@"bathRooms"] ];
    }

    if( self.searchPreferance[@"bedRooms"] != nil ) {
        urlString = [NSString stringWithFormat:@"%@%@%@", urlString, @"&bedrooms=", self.searchPreferance[@"bedRooms"] ];
    }
    NSLog(@"urlString:%@",urlString);
    url = [NSURL URLWithString:urlString];
    
    //NSString *url = @"http://www.rentmetrics.com/api/v1/apartments.json?address=Sunnyvale,CA&api_token=TEST&offset=0&limit=10&include_images=true";
    //NSLog(@"fetching houses");
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        //NSLog(@"%@", object);
        //NSLog(@"Houses fetched");
        self.housesJsonArray = [object valueForKeyPath:@"collection"];
        NSArray *housesJsonArray = [object valueForKeyPath:@"collection"];
        for(int i = 0; i < housesJsonArray.count; i++) {
            NSDictionary *houseDict = [housesJsonArray objectAtIndex:i];
            House *house = [[House alloc] initWithDictionary:houseDict];
            [self.houses addObject:house];
            
        }
        self.start = self.houses.count;
        //NSLog(@"houses Size %d start:%d", self.houses.count, self.start);
        if( self.reloadRequired ) {
            [self.tableView reloadData];
            self.reloadRequired = false;
        } else {
            self.reloadRequired = true;
        }
        if( self.searchPreferanceChanged ) {
            [activityIndicator stopAnimating];
            [activityIndicator removeFromSuperview];
            self.view.userInteractionEnabled = YES;
            self.searchPreferanceChanged = false;
        }


    }];
}
@end
