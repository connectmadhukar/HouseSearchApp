//
//  HomeDetailsViewController.m
//  HomeSearchApp
//
//  Created by Madhukar Mulpuri on 2/2/14.
//  Copyright (c) 2014 Madhukar Mulpuri. All rights reserved.
//

#import "HomeDetailsViewController.h"
#import "AFNetworking.h"

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
    self.houseFeaturesTextView.text = self.house.features;
    [self.houseFeaturesTextView sizeToFit];
    UIImage *image = [UIImage imageNamed: @"homeDeafult.jpeg"];
    [self.houseBImageView setImage:image];
    if(self.house.images.count != 0 ) {
        [self fetchImage:[self.house.images objectAtIndex:0] imageViewToLoadInto:self.houseBImageView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchImage:(NSURL *)imageUrl imageViewToLoadInto:(UIImageView *) imageView{
    NSURLRequest *urlReq = [NSURLRequest requestWithURL:imageUrl];
    AFHTTPRequestOperation *postOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlReq];
    postOperation.responseSerializer = [AFImageResponseSerializer serializer];
    [postOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Response: %@", responseObject);
        imageView.image = responseObject;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Image error: %@", error);
    }];
    [postOperation start];
}

- (IBAction)imageViewTapAction:(id)sender {
    NSLog(@"Tapped");
}

- (IBAction)completeViewTapActionOutlet:(UITapGestureRecognizer *)sender {
    NSLog(@" er Tapped");
    if(self.house.images.count != 0 && self.house.images.count != 1) {
        self.imgNumber = (self.imgNumber +1 )% self.house.images.count;
        [self fetchImage:[self.house.images objectAtIndex:self.imgNumber] imageViewToLoadInto:self.houseBImageView];
    }
}
@end
