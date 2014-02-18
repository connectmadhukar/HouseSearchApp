//
//  RefineViewController.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/11/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "RefineViewController.h"
#import <Parse/Parse.h>
#import "SearchPreferance.h"

@interface RefineViewController ()

@end

@implementation RefineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    PFQuery *query = [SearchPreferance query];
    [query includeKey:@"user"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error && [objects count]>0) {
            self.searchPreferance = objects[0];
            self.addressTxtFld.text    =    self.searchPreferance[@"address"]   ;
            self.distanceTxtFld.text   =    self.searchPreferance[@"distance"]  ;
            self.bathroomsTxtFld.text  =    self.searchPreferance[@"bathRooms"] ;
            self.bedroomsTxtFld.text   =    self.searchPreferance[@"bedRooms"]  ;
        } else {
            self.searchPreferance = [PFObject objectWithClassName:@"SearchPreferance"];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPressed:(id)sender {
    NSLog(@" Save Button Pressed");
    
    self.searchPreferance[@"user"] = [PFUser currentUser];
    self.searchPreferance[@"address"] = self.addressTxtFld.text;
    self.searchPreferance[@"distance"] = self.distanceTxtFld.text;
    self.searchPreferance[@"bathRooms"] = self.bathroomsTxtFld.text;
    self.searchPreferance[@"bedRooms"] = self.bedroomsTxtFld.text;
    [self.delegate searchWithPreferance:(SearchPreferance *)self.searchPreferance];
    [self.searchPreferance saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(succeeded) {
            NSLog(@"succeeded");
        } else {
            NSLog(@"error");
        }
    }];

}
@end
