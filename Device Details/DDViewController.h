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


@interface DDViewController : UIViewController<CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *startPoint;
   
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


@end
