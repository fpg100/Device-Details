//
//  DDViewController.h
//  Device Details
//
//  Created by Robert Yi Jiang on 26/08/13.
//  Copyright (c) 2013 Robert Yi Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#include <sys/types.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <dns.h>
#include<stdlib.h>
#include<netinet/in.h>
#include<unistd.h>
#include <resolv.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/sysctl.h>
#import <sys/utsname.h>
#include <ifaddrs.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <MapKit/MapKit.h>

#define kAccelerometerFrequency        50.0 //Hz
@interface DDViewController : UIViewController<CLLocationManagerDelegate,UIAccelerometerDelegate,MKMapViewDelegate> {
    CLLocationManager *locationManager;
    CLLocation *startPoint;
    CMMotionManager *motionManager;
    NSOperationQueue *opQ;
   
}
//Hardware Details
@property (weak, nonatomic) IBOutlet UILabel *deviceModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;

//OS Details
@property (weak, nonatomic) IBOutlet UILabel *osNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *osVersionLabel;

//Network Details
@property (weak, nonatomic) IBOutlet UITextView *deviceUDIDtextField;
@property (weak, nonatomic) IBOutlet UILabel *networkTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *macAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssidTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssidLabel;
@property (weak, nonatomic) IBOutlet UILabel *routerIpAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *subnetMaskLabel;
@property (weak, nonatomic) IBOutlet UILabel *routerBoradcastAddrLabel;

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
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *countryLabel;
@property (weak, nonatomic) IBOutlet MKMapView *currentLocationMapView;

//Motion Details
//  Gyro
@property (weak, nonatomic) IBOutlet UILabel *gyroTotalRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *xRotateLabel;
@property (weak, nonatomic) IBOutlet UILabel *yRotateLabel;
@property (weak, nonatomic) IBOutlet UILabel *zRotateLabel;
//  DeviceMotion
@property (weak, nonatomic) IBOutlet UILabel *rotateRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *xRotateRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *yRotateRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *zRotateRateLabel;
//  Accelerometer
@property (weak, nonatomic) IBOutlet UILabel *gravityLabel;
@property (weak, nonatomic) IBOutlet UILabel *xAccelerationLabel;
@property (weak, nonatomic) IBOutlet UILabel *yAccelerationLabel;
@property (weak, nonatomic) IBOutlet UILabel *zAccelerationLabel;
//  Magnetic Field
@property (weak, nonatomic) IBOutlet UILabel *magneticFieldTotileLabel;
@property (weak, nonatomic) IBOutlet UILabel *xMagneticFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *yMagneticFieldLabel;
@property (weak, nonatomic) IBOutlet UILabel *zMagneticFieldLabel;


@end
