//
//  DDMainViewController.h
//  Device Details
//
//  Created by Jingxi & Yi on 2/01/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "RNGridMenu.h"
#import "DDViewContainerSegue.h"

@interface DDMainViewController : UIViewController <ADBannerViewDelegate,RNGridMenuDelegate> {
    
    //iAD
    ADBannerView *adView;
}

//iAD
@property(nonatomic,retain)IBOutlet ADBannerView *adView;

@property (weak,nonatomic) UIViewController *destinationViewController;
@property (strong, nonatomic) NSString *destinationIdentifier;
@property (strong, nonatomic) UIViewController *oldViewController;
@property (strong, nonatomic) IBOutlet UIView *detailsViewsContainer;

@end
