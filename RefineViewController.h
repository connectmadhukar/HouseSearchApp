//
//  RefineViewController.h
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/11/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchPreferance.h"
#import "RefineSearch.h"

@interface RefineViewController : UIViewController
@property (weak) id <RefineSearch> delegate;
@property (weak, nonatomic) IBOutlet UIButton *saveBttn;
@property (weak, nonatomic) IBOutlet UITextField *addressTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *distanceTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *bedroomsTxtFld;
@property (weak, nonatomic) IBOutlet UITextField *bathroomsTxtFld;
- (IBAction)saveButtonPressed:(id)sender;
@property (nonatomic, strong) PFObject *searchPreferance;

@end
