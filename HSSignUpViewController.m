//
//  HSSignUpViewController.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/25/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "HSSignUpViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <Parse/Parse.h>

@interface HSSignUpViewController ()

@end

@implementation HSSignUpViewController

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
    self.signUpView.logo = logo;
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.signUpView.usernameField.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.6];
    self.signUpView.usernameField.layer.cornerRadius=20.0f;

    self.signUpView.passwordField.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.4 alpha:0.6];
    self.signUpView.passwordField.layer.cornerRadius=20.0f;

    self.signUpView.emailField.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.6 alpha:0.6];
    self.signUpView.emailField.layer.cornerRadius=20.0f;
}


@end
