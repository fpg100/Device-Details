//
//  DDViewController.m
//  Device Details
//
//  Created by Robert Yi Jiang on 26/08/13.
//  Copyright (c) 2013 Robert Yi Jiang. All rights reserved.
//

#import <sys/sysctl.h>
#import <sys/utsname.h>
#import "DDViewController.h"
#import "Reachability.h"

@interface DDViewController ()

@end


@implementation DDViewController
@synthesize deviceModeLabel;
@synthesize deviceCodeLabel;
@synthesize deviceTypeLabel;
@synthesize deviceNameLabel;
@synthesize deviceUDIDLabel;
@synthesize osNameLabel;
@synthesize osVersionLabel;
@synthesize deviceUDIDtextField;
@synthesize networkTypeLabel;
Reachability *googleReach;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self getDeviceDetails];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    googleReach = [Reachability reachabilityWithHostName:@"www.google.com"];
    [googleReach startNotifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getDeviceDetails{
    struct utsname systemInfo;
    uname(&systemInfo);

    deviceModeLabel.text = [UIDevice currentDevice].model;
    deviceCodeLabel.text = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    if ([platform isEqualToString:@"iPhone1,1"])    deviceTypeLabel.text = @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    deviceTypeLabel.text = @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    deviceTypeLabel.text = @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    deviceTypeLabel.text = @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    deviceTypeLabel.text = @"iPhone 4 CDMA";
    if ([platform isEqualToString:@"iPhone4,1"])    deviceTypeLabel.text = @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    deviceTypeLabel.text = @"iPhone 5";
    if ([platform isEqualToString:@"iPod1,1"])      deviceTypeLabel.text = @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      deviceTypeLabel.text = @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      deviceTypeLabel.text = @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      deviceTypeLabel.text = @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      deviceTypeLabel.text = @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      deviceTypeLabel.text = @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      deviceTypeLabel.text = @"iPad 2 WiFi";
    if ([platform isEqualToString:@"iPad2,2"])      deviceTypeLabel.text = @"iPad 2 GSM";
    if ([platform isEqualToString:@"iPad2,3"])      deviceTypeLabel.text = @"iPad 2 CDMA";
    if ([platform isEqualToString:@"iPad2,4"])      deviceTypeLabel.text = @"iPad 2 CDMAS";
    if ([platform isEqualToString:@"iPad2,5"])      deviceTypeLabel.text = @"iPad Mini Wifi";
    if ([platform isEqualToString:@"iPad2,6"])      deviceTypeLabel.text = @"iPad Mini (Wi-Fi + Cellular)";
    if ([platform isEqualToString:@"iPad2,7"])      deviceTypeLabel.text = @"iPad Mini (Wi-Fi + Cellular MM)";
    if ([platform isEqualToString:@"iPad3,1"])      deviceTypeLabel.text = @"iPad 3 WiFi";
    if ([platform isEqualToString:@"iPad3,2"])      deviceTypeLabel.text = @"iPad 3 CDMA";
    if ([platform isEqualToString:@"iPad3,3"])      deviceTypeLabel.text = @"iPad 3 GSM";
    if ([platform isEqualToString:@"iPad3,4"])      deviceTypeLabel.text = @"iPad 4 Wifi";
    if ([platform isEqualToString:@"i386"])         deviceTypeLabel.text = @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       deviceTypeLabel.text = @"Simulator";
    
    deviceNameLabel.text = [UIDevice currentDevice].name;
    deviceUDIDLabel.text = [[UIDevice currentDevice] uniqueIdentifier];
    deviceUDIDtextField.text = [[UIDevice currentDevice] uniqueIdentifier];

    osNameLabel.text = [UIDevice currentDevice].systemName;
    osVersionLabel.text = [UIDevice currentDevice].systemVersion;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.google.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            networkTypeLabel.text = @"No Network Connetion";
            break;
        case ReachableViaWWAN:
            networkTypeLabel.text = @"Celular Connection";
            break;
        case ReachableViaWiFi:
            networkTypeLabel.text = @"WiFi Connection";
            break;
            
        default:
            break;
    }
    
}

-(void)reachabilityChanged:(NSNotification *)note{
    //When Network Environment is changed
    
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            networkTypeLabel.text = @"No Network Connetion";
            break;
        case ReachableViaWWAN:
            networkTypeLabel.text = @"Celular Connection";
            break;
        case ReachableViaWiFi:
            networkTypeLabel.text = @"WiFi Connection";
            break;
            
        default:
            break;
    }
    
}

@end
