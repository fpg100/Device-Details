//
//  DDMainViewController.m
//  Device Details
//
//  Created by Jingxi & Yi on 2/01/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

#import "DDMainViewController.h"

@interface DDMainViewController ()

@end

@implementation DDMainViewController
@synthesize adView;

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
    adView.delegate =self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"iAdBanner failed\n");
    NSLog(@"%@",[error localizedDescription]);
    
    
}
-(void) bannerViewDidLoadAd:(ADBannerView *)banner
{
    
    NSLog(@"iAdBanner loaded");
    
}


@end
