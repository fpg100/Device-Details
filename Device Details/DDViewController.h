//
//  DDViewController.h
//  Device Details
//
//  Created by Robert Yi Jiang on 26/08/13.
//  Copyright (c) 2013 Robert Yi Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
//

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


//Decibel Meter
#import "F3BarGauge.h"

//CM Pop Tip View
#import "CMPopTipView.h"

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <resolv.h>


#define kAccelerometerFrequency        50.0 //Hz


@interface DDViewController : UIViewController<CLLocationManagerDelegate,UIAccelerometerDelegate,MKMapViewDelegate,CMPopTipViewDelegate> {
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
@property (weak, nonatomic) IBOutlet UILabel *uuidLabel;
@property (strong, nonatomic) IBOutlet UILabel *deviceStorageTotalSizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *deviceStorageUsedSizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *deviceStorageRemainningSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceCpuLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceCpuNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceCpuUsageForAppLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceGpuLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceRAMTotalSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceRAMFreeSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceScreenSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceScreenTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceScreenDensityLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceScreenBrightness;
@property (weak, nonatomic) IBOutlet UILabel *deviceWLANLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceBluetoothLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceCameraFrontLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceCameraBackLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceVideoFrontLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceVideoBackLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceDimentionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceWeightLabel;

//OS Details
@property (weak, nonatomic) IBOutlet UILabel *osNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *osVersionLabel;
@property (weak, nonatomic) IBOutlet UILabel *osJailbrokenLabel;

//Network Details
@property (weak, nonatomic) IBOutlet UITextView *deviceUDIDtextField;
@property (weak, nonatomic) IBOutlet UILabel *networkTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *externalIpAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *networkIpMaskLabel;
@property (weak, nonatomic) IBOutlet UILabel *macAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssidTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssidLabel;
@property (weak, nonatomic) IBOutlet UILabel *routerIpAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *subnetMaskLabel;
@property (weak, nonatomic) IBOutlet UILabel *routerBoradcastAddrLabel;

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
//  Decibel Meter
@property (weak, nonatomic) IBOutlet UILabel *dbPeakPowerValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *dbAveragePowerValueLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *dbPeakPowerProgressView;
@property (weak, nonatomic) IBOutlet UIProgressView *dbAveragePowerProgressView;
@property (weak, nonatomic) IBOutlet F3BarGauge *dbBarGauge;


- (IBAction)turnOnFingScanUrlButtonTouchUpInside:(id)sender;
- (IBAction)turnOnSpectViewUrlButtonTouchUpInside:(id)sender;
- (IBAction)turnOnLightBlueUrlButtonTouchUpInside:(id)sender;
- (IBAction)turnOnStopWatchUrlButtonTouchUpInside:(id)sender;

- (IBAction)fingTitleButtonTouchUpInside:(id)sender;
- (IBAction)spectViewTitleButtonTouchUpInside:(id)sender;
- (IBAction)lightBlueTitleButtonTouchUpInside:(id)sender;
- (IBAction)stopWatchTitleButtonTouchUpInside:(id)sender;



@end
