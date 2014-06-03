//
//  DDCompassDetailsViewController.h
//  Device Details
//
//  Created by Robert Yi Jiang on 03/6/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
//Location Details 
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <MapKit/MapKit.h>

@interface DDCompassDetailsViewController : UIViewController<CLLocationManagerDelegate>

//Compass Details
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UILabel *differWithGeomagneticLabel;
@property (weak, nonatomic) IBOutlet UILabel *trueHeadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *xGeomagnetismLabel;
@property (weak, nonatomic) IBOutlet UILabel *yGeomagnetismLabel;
@property (weak, nonatomic) IBOutlet UILabel *zGeomagnetismLabel;

@end
