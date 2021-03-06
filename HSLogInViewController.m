//
//  HSLogInViewController.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/25/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "HSLogInViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

@interface HSLogInViewController ()

@end

@implementation HSLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIGraphicsBeginImageContext(self.view.frame.size);
    [[UIImage imageNamed:@"TheWay2Home_orig.jpg"] drawInRect:self.view.bounds];
    UIImage *bgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImage];
    
    UIImage *image = [UIImage imageNamed: @"homeSearchSmall.jpeg"];
    UIImageView *logo = [[UIImageView alloc] initWithImage:image];
    logo.layer.cornerRadius = 25.0;
    logo.layer.masksToBounds = YES;
    self.logInView.logo = logo; // logo can be any UIView
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.logInView.usernameField.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.6];
    
    self.logInView.usernameField.layer.cornerRadius=20.0f;
    self.logInView.passwordField.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.6];
    self.logInView.passwordField.layer.cornerRadius=20.0f;

    
}

@end
