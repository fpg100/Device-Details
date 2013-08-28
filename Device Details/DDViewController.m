//
//  DDViewController.m
//  Device Details
//
//  Created by Robert Yi Jiang on 26/08/13.
//  Copyright (c) 2013 Robert Yi Jiang. All rights reserved.
//
#import "DDViewController.h"

@interface DDViewController ()

@end


@implementation DDViewController
@synthesize deviceModeLabel;
@synthesize deviceCodeLabel;
@synthesize deviceTypeLabel;
@synthesize deviceNameLabel;
@synthesize osNameLabel;
@synthesize osVersionLabel;
@synthesize deviceUDIDtextField;
@synthesize networkTypeLabel;
@synthesize ipAddrLabel;
@synthesize macAddrLabel;
@synthesize ssidLabel;
@synthesize ssidTagLabel;
@synthesize routerIpAddrLabel;
@synthesize subnetMaskLabel;
@synthesize routerBoradcastAddrLabel;
@synthesize locationManager;
@synthesize startPoint;
@synthesize latitudeLabel;
@synthesize longitudeLabel;
@synthesize horizentalAccuratcyLabel;
@synthesize altitudeLabel;
@synthesize verticalAccuracyLabel;

Reachability *googleReach;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 2.0f;
    [locationManager startUpdatingLocation];
    
    [self getDeviceDetails];
    [self getLocationDetails];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    googleReach = [Reachability reachabilityWithHostName:@"www.google.com"];
    [googleReach startNotifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getLocationDetails{
    
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
    deviceUDIDtextField.text = [[UIDevice currentDevice] uniqueIdentifier];

    osNameLabel.text = [UIDevice currentDevice].systemName;
    osVersionLabel.text = [UIDevice currentDevice].systemVersion;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.google.com"];
    ssidLabel.hidden = YES;
    ssidTagLabel.hidden = YES;
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            networkTypeLabel.text = @"No Network";
            break;
        case ReachableViaWWAN:
            networkTypeLabel.text = @"3G/GPRS";
            break;
        case ReachableViaWiFi:
            networkTypeLabel.text = @"WiFi";
            ssidLabel.text = [self getSSIDInfo];
            ssidLabel.hidden = NO;
            ssidTagLabel.hidden = NO;
            break;
            
        default:
            break;
    }
    
    ipAddrLabel.text = [self getIPAddress];
    macAddrLabel.text = [self getMacAddress];
    
    [self get_dns_servers];
}

///Get IP Address

//- (NSString *)getIPAddress {
//    NSString *address = @"error";
//    struct ifaddrs *interfaces = NULL;
//    struct ifaddrs *temp_addr = NULL;
//    int success = 0;
//    // retrieve the current interfaces - returns 0 on success
//    success = getifaddrs(&interfaces);
//    if (success == 0) {
//        // Loop through linked list of interfaces
//        temp_addr = interfaces;
//        while(temp_addr != NULL) {
//            if(temp_addr->ifa_addr->sa_family == AF_INET) {
//                // Check if interface is en0 which is the wifi connection on the iPhone
//                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
//                    // Get NSString from C String
//                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
//                }
//            }
//            temp_addr = temp_addr->ifa_next;
//        }
//    }
//    // Free memory
//    freeifaddrs(interfaces);
//    return address;
//    
//}
- (NSString *)getIPAddress
{
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    NSString *wifiAddress = nil;
    NSString *cellAddress = nil;
    
    // retrieve the current interfaces - returns 0 on success
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            sa_family_t sa_type = temp_addr->ifa_addr->sa_family;
            if(sa_type == AF_INET || sa_type == AF_INET6) {
                NSString *name = [NSString stringWithUTF8String:temp_addr->ifa_name];
                NSString *addr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]; // pdp_ip0
                NSLog(@"NAME: \"%@\" addr: %@", name, addr); // see for yourself
                
                if([name isEqualToString:@"en0"]) {
                    // Interface is the wifi connection on the iPhone
                    wifiAddress = addr;
                } else
                    if([name isEqualToString:@"pdp_ip0"]) {
                        // Interface is the cell connection on the iPhone
                        cellAddress = addr;
                    }
            }
            temp_addr = temp_addr->ifa_next;
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    NSString *addr = wifiAddress ? wifiAddress : cellAddress;
    return addr ? addr : @"0.0.0.0";
}

///Get Mac Address
- (NSString *)getMacAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET;        // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE;       // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;        // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST;  // Request all configured interfaces
    
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        // Get the size of the data available (store in len)
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            // Alloc memory based on above call
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                // Get system information, store in buffer
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    // Befor going any further...
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        return errorFlag;
    }
    
    // Map msgbuffer to interface message structure
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    // Map to link-level socket structure
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    // Copy link layer address data in socket structure to an array
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    // Read from char array into a string object, into traditional Mac address format
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    NSLog(@"Mac Address: %@", macAddressString);
    
    // Release the buffer memory
    free(msgBuffer);
    
    return macAddressString;
}

//Get WiFi SSID
- (NSString *)getSSIDInfo{
    // Does not work on the simulator.
    NSString *ssid = nil;
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
        }
    }
    return ssid;
}

-(NSString *) get_dns_servers
{
  
//    struct ifaddrs *ifa = NULL, *ifList;
//    getifaddrs(&ifList); // should check for errors
//    NSLog(@"ifList %@",ifList);
//    for (ifa = ifList; ifa != NULL; ifa = ifa->ifa_next) {
//        NSLog(@"ifa->ifa_addr : %@", ifa->ifa_addr); // interface address
//        NSLog(@"ifa->ifa_netmask : %@", ifa->ifa_netmask); // subnet mask
//         NSLog(@"ifa->ifa_dstaddr : %@", ifa->ifa_dstaddr); // broadcast address, NOT router address
//    }
//    freeifaddrs(ifList); // clean up after yourself
    return @"0.0.0.0";
}


#pragma mark -
#pragma mark *** Reachability Delegate ***
-(void)reachabilityChanged:(NSNotification *)note{
    //When Network Environment is changed
    
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    ssidLabel.hidden = YES;
    ssidTagLabel.hidden = YES;
    switch (status) {
        case NotReachable:
            networkTypeLabel.text = @"No Network Connetion";
            break;
        case ReachableViaWWAN:
            networkTypeLabel.text = @"Celular Connection";
            break;
        case ReachableViaWiFi:
            networkTypeLabel.text = @"WiFi";
            ssidLabel.text = [self getSSIDInfo];
            ssidLabel.hidden = NO;
            ssidTagLabel.hidden = NO;
            break;
            
        default:
            break;
    }
    ipAddrLabel.text = [self getIPAddress];
}



#pragma mark *** CLLocationManager Delegate ***
/*
 *  locationManager:didUpdateLocations:
 *
 *  Discussion:
 *    Invoked when new locations are available.  Required for delivery of
 *    deferred locations.  If implemented, updates will
 *    not be delivered to locationManager:didUpdateToLocation:fromLocation:
 *
 *    locations is an array of CLLocation objects in chronological order.
 */
- (void)locationManager:(CLLocationManager *)manager
didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation = [locations lastObject];
    CLLocation *oldLocation;
    if (locations.count > 1) {
        oldLocation = [locations objectAtIndex:locations.count-2];
    } else {
        oldLocation = nil;
    }
    NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
    
    
}





@end







