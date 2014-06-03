//
//  DDCompassDetailsViewController.m
//  Device Details
//
//  Created by Robert Yi Jiang on 03/6/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

#import "DDCompassDetailsViewController.h"

@interface DDCompassDetailsViewController ()

@end

@implementation DDCompassDetailsViewController

//Compass Details
@synthesize locationManager;
@synthesize headingLabel;
@synthesize differWithGeomagneticLabel;
@synthesize trueHeadingLabel;
@synthesize xGeomagnetismLabel;
@synthesize yGeomagnetismLabel;
@synthesize zGeomagnetismLabel;

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
    
    
    [self initCompassDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initCompassDetails{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 5.0f;
    locationManager.headingFilter = kCLHeadingFilterNone;
    [locationManager startUpdatingHeading];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/*
 *  locationManager:didUpdateHeading:
 *
 *  Discussion:
 *    Invoked when a new heading is available.
 */
- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading{
    
    //    [headingLabel setText:[NSString stringWithFormat:@"%.1fmi",newHeading.magneticHeading]];
    headingLabel.Text = [NSString stringWithFormat:@"%.2f\u00B0",newHeading.magneticHeading];
    differWithGeomagneticLabel.text =[NSString stringWithFormat:@"%.1fmi",newHeading.headingAccuracy];
    trueHeadingLabel.text = [NSString stringWithFormat:@"%.2f\u00B0",newHeading.trueHeading];
    xGeomagnetismLabel.text = [NSString stringWithFormat:@"%.1f\u00B0",newHeading.x];
    yGeomagnetismLabel.text = [NSString stringWithFormat:@"%.1f\u00B0",newHeading.y];
    zGeomagnetismLabel.text = [NSString stringWithFormat:@"%.1f\u00B0",newHeading.z];
    
}

@end
