//
//  TodayViewController.h
//  DD Widget
//
//  Created by Robert Yi Jiang on 07/7/2015.
//  Copyright (c) 2015 Robert Yi Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <resolv.h>

//Network Details
#import "Reachability.h"
#include <sys/socket.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <dns.h>
#include <netinet/in.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>

//Hardware and OS Details
#include <sys/types.h>
#import <sys/sysctl.h>
#import <sys/utsname.h>
#import <mach/mach.h>
#define MB (1024*1024)
#define GB (MB*1024)

//Location Details
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <MapKit/MapKit.h>

@interface TodayViewController : UIViewController
- (IBAction)networkButtonTouchUpInSide:(id)sender;
- (IBAction)locationButtonTouchUpInSide:(id)sender;
- (IBAction)storageButtonTouchUpInSide:(id)sender;
- (IBAction)timeBatteryButtonTouchUpInSide:(id)sender;
- (IBAction)jailbreakButtonTouchUpInSide:(id)sender;

//Network Details
@property (weak, nonatomic) IBOutlet UILabel *networkTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *externalIpAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *networkIpMaskLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssidTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssidLabel;

//Date Time
@property (strong, nonatomic) IBOutlet UILabel *localDateTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *utcDateTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *bootTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *uptimeLabel;

//Location Details
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (retain, nonatomic) CLLocation *startPoint;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *horizentalAccuratcyLabel;
@property (weak, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *verticalAccuracyLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UILabel *differWithGeomagneticLabel;
@property (weak, nonatomic) IBOutlet UILabel *trueHeadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *xGeomagnetismLabel;
@property (weak, nonatomic) IBOutlet UILabel *yGeomagnetismLabel;
@property (weak, nonatomic) IBOutlet UILabel *zGeomagnetismLabel;
@property (strong, nonatomic) NSMutableDictionary *placeDictionary;
@property (weak, nonatomic) IBOutlet UILabel *placeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *neighborhoodLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *countyLabel;
@property (weak, nonatomic) IBOutlet UILabel *zipCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *inlandWaterLabel;
@property (weak, nonatomic) IBOutlet UILabel *oceanLabel;
@property (weak, nonatomic) IBOutlet UILabel *areasOfInterestLabel;
@end
