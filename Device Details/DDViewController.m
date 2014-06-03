//
//  DDViewController.m
//  Device Details
//
//  Created by Robert Yi Jiang on 26/08/13.
//  Copyright (c) 2013 Robert Yi Jiang. All rights reserved.
//
#import "DDViewController.h"
#import "BBDecibelMeter.h"
#import "ALSystem.h"

@interface DDViewController (){
 

}

//@property (nonatomic, strong) BBDecibelMeter *dbDecibelMeter;
@property (nonatomic, strong) BBDecibelMeter *meter;

//CM Pop Tip View
@property (nonatomic, strong)	NSArray			*colorSchemes;
@property (nonatomic, strong)	NSDictionary	*contents;
@property (nonatomic, strong)	id				currentPopTipViewTarget;
@property (nonatomic, strong)	NSDictionary	*titles;
@property (nonatomic, strong)	NSMutableArray	*visiblePopTipViews;

@end


@implementation DDViewController

//Hardware Details
@synthesize deviceModeLabel;
@synthesize deviceCodeLabel;
@synthesize deviceTypeLabel;
@synthesize deviceNameLabel;
@synthesize uuidLabel;
@synthesize deviceStorageTotalSizeLabel;
@synthesize deviceStorageUsedSizeLabel;
@synthesize deviceStorageRemainningSizeLabel;
@synthesize deviceCpuLabel;
@synthesize deviceCpuNumberLabel;
@synthesize deviceCpuUsageForAppLabel;
@synthesize deviceGpuLabel;
@synthesize deviceRAMTotalSizeLabel;
@synthesize deviceRAMFreeSizeLabel;
@synthesize deviceScreenSizeLabel;
@synthesize deviceScreenTypeLabel;
@synthesize deviceScreenDensityLabel;
@synthesize deviceScreenBrightness;
@synthesize deviceWLANLabel;
@synthesize deviceBluetoothLabel;
@synthesize deviceCameraFrontLabel;
@synthesize deviceCameraBackLabel;
@synthesize deviceDimentionsLabel;
@synthesize deviceWeightLabel;


//OS Details
@synthesize osNameLabel;
@synthesize osVersionLabel;
@synthesize osJailbrokenLabel;

//Network Details
@synthesize networkTypeLabel;
@synthesize externalIpAddrLabel;
@synthesize ipAddrLabel;
@synthesize networkIpMaskLabel;
@synthesize macAddrLabel;
@synthesize ssidLabel;
@synthesize ssidTagLabel;
@synthesize routerIpAddrLabel;
@synthesize subnetMaskLabel;
@synthesize routerBoradcastAddrLabel;

//Date Time
@synthesize localDateTimeLabel;
@synthesize utcDateTimeLabel;

//Compass Details
@synthesize headingLabel;
@synthesize differWithGeomagneticLabel;
@synthesize trueHeadingLabel;
@synthesize xGeomagnetismLabel;
@synthesize yGeomagnetismLabel;
@synthesize zGeomagnetismLabel;

//Location Details
@synthesize locationManager;
@synthesize startPoint;
@synthesize latitudeLabel;
@synthesize longitudeLabel;
@synthesize horizentalAccuratcyLabel;
@synthesize altitudeLabel;
@synthesize verticalAccuracyLabel;
@synthesize speedLabel;
@synthesize courseLabel;
@synthesize placeDictionary;

@synthesize placeNameLabel;
@synthesize addressNumberLabel;
@synthesize addressLabel;
@synthesize cityLabel;
@synthesize neighborhoodLabel;
@synthesize stateLabel;
@synthesize countyLabel;
@synthesize zipCodeLabel;
@synthesize countryLabel;
@synthesize countryCodeLabel;
@synthesize inlandWaterLabel;
@synthesize oceanLabel;
@synthesize areasOfInterestLabel;
@synthesize currentLocationMapView;

//Motion Details
@synthesize gyroTotalRateLabel;
@synthesize xRotateLabel;
@synthesize yRotateLabel;
@synthesize zRotateLabel;

@synthesize rotateRateLabel;
@synthesize xRotateRateLabel;
@synthesize yRotateRateLabel;
@synthesize zRotateRateLabel;

@synthesize gravityLabel;
@synthesize xAccelerationLabel;
@synthesize yAccelerationLabel;
@synthesize zAccelerationLabel;

@synthesize magneticFieldTotileLabel;
@synthesize xMagneticFieldLabel;
@synthesize yMagneticFieldLabel;
@synthesize zMagneticFieldLabel;

//Decibel Meter
@synthesize dbAveragePowerProgressView;
@synthesize dbAveragePowerValueLabel;
@synthesize dbBarGauge;
@synthesize dbPeakPowerProgressView;
@synthesize dbPeakPowerValueLabel;



Reachability *googleReach;
MKCoordinateRegion viewRegion;
CLLocationCoordinate2D zoomLocation;
CLGeocoder *geocoder;

#pragma mark -
#pragma mark   View Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    [self getDeviceDetails];
    
    [self getNetworkDetails];
    
    [self initDateTimeDetails];
    
    [self initLocationDetails];
    
    [self initMotionDetails];
    
    [self getMotionDetails];
    
    [self initDecibelMeter];
    
    [self initPopTipView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initMotionDetails{
    //Motion
    motionManager = [[CMMotionManager alloc] init];
//    NSLog(@"motionManager.description:%@", motionManager.description);
    motionManager.deviceMotionUpdateInterval = 5.0/100.0;
    motionManager.gyroUpdateInterval = 1.0/60.0;
    motionManager.accelerometerUpdateInterval = 5.0/100.0;
    motionManager.magnetometerUpdateInterval  = 1.0/10.0; // Update at 10Hz
    //    [motionManager startAccelerometerUpdates];
    //    [motionManager startDeviceMotionUpdates];
    //    [motionManager startGyroUpdates];
}
     
- (void)initLocationDetails{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 5.0f;
    [locationManager startUpdatingLocation];
    locationManager.headingFilter = kCLHeadingFilterNone;
    [locationManager startUpdatingHeading];
    placeDictionary = [[NSMutableDictionary alloc] init];
    geocoder = [[CLGeocoder alloc] init];
}

#pragma mark -
#pragma mark   Hardware Details Functions
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
    if ([platform isEqualToString:@"iPhone3,3"])    deviceTypeLabel.text = @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    deviceTypeLabel.text = @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    deviceTypeLabel.text = @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    deviceTypeLabel.text = @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    deviceTypeLabel.text = @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    deviceTypeLabel.text = @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    deviceTypeLabel.text = @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    deviceTypeLabel.text = @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPod1,1"])      deviceTypeLabel.text = @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      deviceTypeLabel.text = @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      deviceTypeLabel.text = @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      deviceTypeLabel.text = @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      deviceTypeLabel.text = @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      deviceTypeLabel.text = @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      deviceTypeLabel.text = @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      deviceTypeLabel.text = @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      deviceTypeLabel.text = @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      deviceTypeLabel.text = @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      deviceTypeLabel.text = @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      deviceTypeLabel.text = @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      deviceTypeLabel.text = @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      deviceTypeLabel.text = @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      deviceTypeLabel.text = @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      deviceTypeLabel.text = @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      deviceTypeLabel.text = @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      deviceTypeLabel.text = @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      deviceTypeLabel.text = @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"i386"])         deviceTypeLabel.text = @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       deviceTypeLabel.text = @"Simulator";
    
    deviceNameLabel.text = [UIDevice currentDevice].name;
    //deviceUDIDtextField.text = [[UIDevice currentDevice]  uniqueIdentifier];

    uuidLabel.text = [UIDevice currentDevice].identifierForVendor.UUIDString;
    deviceStorageTotalSizeLabel.text = [self totalDiskSpace];
    deviceStorageUsedSizeLabel.text  = [self usedDiskSpace];
    deviceStorageRemainningSizeLabel.text = [self freeDiskSpace];
    deviceCpuLabel.text = [ALHardware cpu];
    deviceCpuNumberLabel.text = [NSString stringWithFormat:@"%ld", [ALProcessor processorsNumber]];
    deviceCpuUsageForAppLabel.text =  [NSString stringWithFormat:@"%.1f%%", [ALProcessor cpuUsageForApp]*100];
    deviceGpuLabel.text = [ALHardware gpu];
    deviceRAMTotalSizeLabel.text = [NSString stringWithFormat:@"%ldMB",[ALMemory totalMemory]];
    deviceRAMFreeSizeLabel.text = [NSString stringWithFormat:@"%.1fMB",[ALMemory freeMemory]];
    deviceScreenSizeLabel.text = [NSString stringWithFormat:@"%ld * %ld",[ALHardware screenHeight],(long)[ALHardware screenWidth]];
    deviceScreenTypeLabel.text = [ALHardware displayType];
    deviceScreenDensityLabel.text = [ALHardware displayDensity];
    deviceScreenBrightness.text = [NSString stringWithFormat:@"%.2f",[ALHardware brightness]];
    deviceWLANLabel.text = [ALHardware WLAN];
    deviceBluetoothLabel.text = [ALHardware bluetooth];
    deviceCameraFrontLabel.text = [ALHardware cameraSecondary];
    deviceCameraBackLabel.text = [ALHardware cameraPrimary];
    deviceDimentionsLabel.text = [ALHardware dimensions];
    deviceWeightLabel.text = [ALHardware weight];
    
    osNameLabel.text = [UIDevice currentDevice].systemName;
    osVersionLabel.text = [UIDevice currentDevice].systemVersion;
    osJailbrokenLabel.text = [NSString stringWithFormat:@"%@",([ALJailbreak isJailbroken]?@"YES":@"NO")];
//    NSLog(@"Carrier Name: %@",[ALCarrier carrierName]);
    

}

- (NSString *)memoryFormatter:(long long)diskSpace {
    NSString *formatted;
    double bytes = 1.0 * diskSpace;
    double megabytes = bytes / MB;
    double gigabytes = bytes / GB;
    if (gigabytes >= 1.0)
        formatted = [NSString stringWithFormat:@"%.2f GB", gigabytes];
    else if (megabytes >= 1.0)
        formatted = [NSString stringWithFormat:@"%.2f MB", megabytes];
    else
        formatted = [NSString stringWithFormat:@"%.2f bytes", bytes];
    
    return formatted;
}


- (NSString *)totalDiskSpace {
    long long space = [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemSize] longLongValue];
    return [self memoryFormatter:space];
}

- (NSString *)freeDiskSpace {
    long long freeSpace = [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemFreeSize] longLongValue];
    return [self memoryFormatter:freeSpace];
}

- (NSString *)usedDiskSpace {
    return [self memoryFormatter:[self usedDiskSpaceInBytes]];
}

- (CGFloat)totalDiskSpaceInBytes {
    long long space = [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemSize] longLongValue];
    return space;
}

- (CGFloat)freeDiskSpaceInBytes {
    long long freeSpace = [[[[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil] objectForKey:NSFileSystemFreeSize] longLongValue];
    return freeSpace;
}

- (CGFloat)usedDiskSpaceInBytes {
    long long usedSpace = [self totalDiskSpaceInBytes] - [self freeDiskSpaceInBytes];
    return usedSpace;
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


#pragma mark -
#pragma mark   Network Details Functions

- (void)getNetworkDetails{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    googleReach = [Reachability reachabilityWithHostName:@"www.google.com"];
    [googleReach startNotifier];
    ssidLabel.hidden = YES;
    ssidTagLabel.hidden = YES;
    int reachabilityStatusIndexInt = [googleReach currentReachabilityStatus];
    switch (reachabilityStatusIndexInt) {
        case NotReachable:
            networkTypeLabel.text = @"No Network";
            ssidLabel.hidden = YES;
            ssidTagLabel.hidden = YES;
            externalIpAddrLabel.hidden = YES;
            break;
        case ReachableViaWWAN:
            networkTypeLabel.text = @"Cellular";
            ssidLabel.hidden = YES;
            ssidTagLabel.hidden = YES;
            externalIpAddrLabel.hidden = YES;
            break;
        case ReachableViaWiFi:
            networkTypeLabel.text = @"WiFi";
            ssidLabel.text = [self getSSIDInfo];
            [self updatePublicIP];
            ssidLabel.hidden = NO;
            ssidTagLabel.hidden = NO;
            externalIpAddrLabel.hidden = NO;
            networkIpMaskLabel.text = [ALNetwork WiFiNetmaskAddress];
            break;
        default:
            break;
    }
    
    [self updatePublicIP];
    NSString *ipAddressString = [self getIPAddress];
    NSString *networkIpMaskString = [ALNetwork WiFiNetmaskAddress];
    NSString *macAddressString = [self getMacAddress];
//        [self getDnsServers];
    ipAddrLabel.text = ipAddressString;
    networkIpMaskLabel.text = networkIpMaskString;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1){
        macAddrLabel.text = [self getMacAddress];
    }else {
        macAddrLabel.text = @"Only for iOS 6.1 and lower";
    }

}

- (void)updatePublicIP{
    dispatch_queue_t ipAddress1stQueue = dispatch_queue_create("com.robert.yi.jones.details.network1", NULL);
    dispatch_queue_t ipAddress2ndQueue = dispatch_queue_create("com.robert.yi.jones.details.network2", NULL);
    dispatch_queue_t ipAddress3rdQueue = dispatch_queue_create("com.robert.yi.jones.details.network3", NULL);
    __block BOOL publicIpDidUpdate = NO;
    dispatch_async(ipAddress1stQueue, ^{
        NSString *externalIpAddressString;
        externalIpAddressString = [self getPublicIPAddressFromWtfIsMyIpCom];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!publicIpDidUpdate) {
                externalIpAddrLabel.text = externalIpAddressString;
                publicIpDidUpdate = YES;
            }
        });
        
    });
    dispatch_async(ipAddress2ndQueue, ^{
        NSString *externalIpAddressString;
        externalIpAddressString = [self getPublicIPAddressFromIpEchoNet];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!publicIpDidUpdate) {
                externalIpAddrLabel.text = externalIpAddressString;
                publicIpDidUpdate = YES;
            }
        });
        
    });
    
    dispatch_async(ipAddress3rdQueue, ^{
        NSString *externalIpAddressString;
        externalIpAddressString = [self getPublicIPAddressFromMyIpAddressCom];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!publicIpDidUpdate) {
                externalIpAddrLabel.text  = externalIpAddressString;
                publicIpDidUpdate = YES;
            }
        });
        
    });
}
    


- (NSString *)getPublicIPAddressFromWtfIsMyIpCom{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://wtfismyip.com/text"]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:3];
    [request setHTTPMethod: @"GET"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSLog(@"wtfismyip.com : %@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    return [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] ;
    }

- (NSString *)getPublicIPAddressFromIpEchoNet{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://ipecho.net/plain"]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:3];
    [request setHTTPMethod: @"GET"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSLog(@"ipecho.net : %@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
    return [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] ;
}

- (NSString *)getPublicIPAddressFromMyIpAddressCom{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://www.myipaddress.com/"]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:3];
    [request setHTTPMethod: @"GET"];
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
//    NSLog(@"responseString: %@",responseString);
    NSString *regExpString = @"\\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01‌​]?[0-9][0-9]?)\\b";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regExpString
                                                                           options:0
                                                                             error:NULL];
    NSTextCheckingResult *match = [regex firstMatchInString:responseString
                                                    options:0
                                                      range:NSMakeRange(0, [responseString length])];
    NSLog(@"www.myipaddress.com : %@",[responseString substringWithRange:[match rangeAtIndex:0]]);
    return [responseString substringWithRange:[match rangeAtIndex:0]] ;
}

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
//                NSLog(@"NAME: \"%@\" addr: %@", name, addr); // see for yourself
                
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

/**
 *	getMacAddress is depreciated since iOS 7
 *
 *	@return	MAC Address
 */
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
    // NSLog(@"Error: %@", errorFlag);
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
//    NSLog(@"Mac Address: %@", macAddressString);
    
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

-(NSString *) getDnsServers{
  
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

#pragma mark   Reachability Delegate
-(void)reachabilityChanged:(NSNotification *)note{
    //When Network Environment is changed
    
    Reachability *curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    ssidLabel.hidden = YES;
    ssidTagLabel.hidden = YES;
    externalIpAddrLabel.hidden = YES;
    switch (status) {
        case NotReachable:
            networkTypeLabel.text = @"No Network";
            ssidLabel.hidden = YES;
            ssidTagLabel.hidden = YES;
            externalIpAddrLabel.hidden = YES;
            break;
        case ReachableViaWWAN:
            networkTypeLabel.text = @"Cellular";
            ssidLabel.hidden = YES;
            ssidTagLabel.hidden = YES;
            externalIpAddrLabel.hidden = YES;
            break;
        case ReachableViaWiFi:
            networkTypeLabel.text = @"WiFi";
            ssidLabel.text = [self getSSIDInfo];
            [self updatePublicIP];
            ssidLabel.hidden = NO;
            ssidTagLabel.hidden = NO;
            externalIpAddrLabel.hidden = NO;
            networkIpMaskLabel.text = [ALNetwork WiFiNetmaskAddress];
            break;
            
        default:
            break;
    }
    ipAddrLabel.text = [self getIPAddress];
}


#pragma mark - Date Time Details Functions
-(void) initDateTimeDetails{
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(timerTick:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)timerTick:(NSTimer *)timer {
    NSDate *now = [NSDate date];
    
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"HH:mm:ss  dd-MMM-yyyy";  // very simple format  "18:47:22 28-Nov-2013"
    }
    localDateTimeLabel.text = [dateFormatter stringFromDate:now];
    
    
    static NSDateFormatter *utcDateFormatter;
    if (!utcDateFormatter) {
        utcDateFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *utcTimeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [utcDateFormatter setTimeZone:utcTimeZone];
        [utcDateFormatter setDateFormat:@"HH:mm:ss  dd-MMM-yyyy"];
    }
    utcDateTimeLabel.text = [utcDateFormatter stringFromDate:now];
}

#pragma mark - Motion Details Functions

/**
 *                      At 100Hz                At 20Hz
 *                  Total   Application     Total	Application
 *DeviceMotion      65%         20%         65%         10%
 *Accelerometer     50%         15%         46%         5%
 *Accel + Gyro      51%         10%         50%         5%
 */
-(void) getMotionDetails{
    opQ = [NSOperationQueue currentQueue];
    [motionManager startGyroUpdatesToQueue: opQ
                               withHandler: ^(CMGyroData *gyroData,
                                              NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             CMRotationRate rotate = gyroData.rotationRate;
//             NSLog(@"rotation rate = [%f, %f, %f]", rotate.x, rotate.y, rotate.z);
             xRotateLabel.text = [[NSString alloc] initWithFormat:@"%+.1f", rotate.x];
             yRotateLabel.text = [[NSString alloc] initWithFormat:@"%+.1f", rotate.y];
             zRotateLabel.text = [[NSString alloc] initWithFormat:@"%+.1f", rotate.z];
             gyroTotalRateLabel.text = [[NSString alloc] initWithFormat:@"%+.1f", sqrtf(powf(rotate.x, 2.0) + powf(rotate.y, 2.0) + powf(rotate.z, 2.0))];
         });
     }];
    [motionManager startDeviceMotionUpdatesToQueue:opQ
                                       withHandler:^(CMDeviceMotion *motion, NSError *error)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            rotateRateLabel.text = [[NSString alloc] initWithFormat:@"%+.1f", sqrtf(powf(motion.rotationRate.x, 2.0) + powf(motion.rotationRate.y, 2.0) + powf(motion.rotationRate.z, 2.0))];
            xRotateRateLabel.text = [[NSString alloc] initWithFormat:@"%+.1f", motion.rotationRate.x];
            yRotateRateLabel.text = [[NSString alloc] initWithFormat:@"%+.1f", motion.rotationRate.y];
            zRotateRateLabel.text = [[NSString alloc] initWithFormat:@"%+.1f", motion.rotationRate.z];
        });
    }];
    [motionManager startAccelerometerUpdatesToQueue:opQ
                                        withHandler:^(CMAccelerometerData *accelerometerData,
                                                      NSError *error)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             CMAcceleration acceler = accelerometerData.acceleration;
             gravityLabel.text = [[NSString alloc] initWithFormat:@"%+.1f", sqrtf(powf(acceler.x, 2.0) + powf(acceler.y, 2.0) + powf(acceler.z, 2.0))];
             xAccelerationLabel.text = [NSString stringWithFormat:@"%+.1f",accelerometerData.acceleration.x];
             yAccelerationLabel.text = [NSString stringWithFormat:@"%+.1f",accelerometerData.acceleration.y];
             zAccelerationLabel.text = [NSString stringWithFormat:@"%+.1f",accelerometerData.acceleration.z];
         });
     }];

    [motionManager startMagnetometerUpdatesToQueue:opQ
                                       withHandler:^(CMMagnetometerData *magnetometerData, NSError *error) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               CMMagneticField magneticField = magnetometerData.magneticField;
                                               xMagneticFieldLabel.text = [NSString stringWithFormat:@"%+.1f", magneticField.x];
                                               yMagneticFieldLabel.text = [NSString stringWithFormat:@"%+.1f", magneticField.y];
                                               zMagneticFieldLabel.text = [NSString stringWithFormat:@"%+.1f", magneticField.z];
                                               magneticFieldTotileLabel.text = [NSString stringWithFormat:@"%+.4f",
                                                                  sqrtf(powf(magneticField.x, 2.0) +
                                                                        powf(magneticField.y, 2.0) +
                                                                        powf(magneticField.z, 2.0))];
                                           });
                                       }];
}


#pragma mark -
#pragma mark   CLLocationManager Delegate
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
//    NSLog(@"didUpdateToLocation %@ from %@", newLocation, oldLocation);
    latitudeLabel.text = [[NSString alloc] initWithFormat:@"%+f\u00B0", newLocation.coordinate.latitude];
    longitudeLabel.text = [[NSString alloc] initWithFormat:@"%+f\u00B0", newLocation.coordinate.longitude];
    horizentalAccuratcyLabel.text = [[NSString alloc] initWithFormat:@"+/-%.2f m", newLocation.horizontalAccuracy];
    altitudeLabel.text = [[NSString alloc] initWithFormat:@"%+.2f m", newLocation.altitude];
    verticalAccuracyLabel.text = [[NSString alloc] initWithFormat:@"+/-%.2f m", newLocation.verticalAccuracy];
    speedLabel.text =  [[NSString alloc] initWithFormat:@"%.2f km/h", newLocation.speed];
    if (newLocation.course < 0) {
        courseLabel.text = @"Direction is invalid.";
    }else{
        courseLabel.text = [[NSString alloc] initWithFormat:@"%.2f\u00B0", newLocation.course];
    }
    
    viewRegion = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 320.00,80.00);
    [currentLocationMapView setRegion:viewRegion animated:YES];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if(placemarks.count){
            
//            NSDictionary *dictionary = [[placemarks objectAtIndex:0] addressDictionary];
//            addressLabel.Text = [dictionary valueForKey:@"Street"];
//            cityLabel.Text = [dictionary valueForKey:@"City"];
//            stateLabel.Text = [dictionary valueForKey:@"State"];
//            zipCodeLabel.Text = [dictionary valueForKey:@"ZIP"];
//            countryLabel.text = [dictionary valueForKey:@"Country"];
//            countryCodeLabel.text = [dictionary valueForKey:@"CountryCode"];
            
            
            placeNameLabel.text = [placemarks[0] name];
            addressNumberLabel.text = [placemarks[0] subThoroughfare];
            addressLabel.text = [placemarks[0] thoroughfare];
            neighborhoodLabel.text = [placemarks[0] subLocality];
            cityLabel.text = [placemarks[0] locality];
            countyLabel.text = [placemarks[0] subAdministrativeArea];
            stateLabel.text = [placemarks[0] administrativeArea];
            zipCodeLabel.text = [placemarks[0] postalCode];
            countryLabel.text = [placemarks[0] country];
            countryCodeLabel.text = [placemarks[0] ISOcountryCode];
            inlandWaterLabel.text = [placemarks[0] inlandWater];
            oceanLabel.text = [placemarks[0] ocean];
            if ([[placemarks[0] areasOfInterest] count] >=1) {
                areasOfInterestLabel.text = [[placemarks[0] areasOfInterest] objectAtIndex:0];
            }
        }
    }];
}


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



#pragma mark - Decibel Meter Intialise & Observe

- (void) initDecibelMeter{
    dbPeakPowerProgressView.trackImage = nil;
//    dbPeakPowerProgressView.trackTintColor = [UIColor clearColor];
    dbAveragePowerProgressView.trackImage = nil;
//    dbAveragePowerProgressView.trackTintColor = [UIColor clearColor];
    
    self.meter = [BBDecibelMeter meter];
    self.meter.interval = 1/30;
    [self.meter startMeasuring];
    
    [self.meter addObserver:self
                          forKeyPath:kBBDecibelMeterAvgPowerKey
                             options:0
                             context:nil];
    
    [self.meter addObserver:self
                          forKeyPath:kBBDecibelMeterPeakPowerKey
                             options:0
                             context:nil];
    
    dbBarGauge.numBars = 20;
    dbBarGauge.holdPeak = YES;
}

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary *)change
                        context:(void *)context
{
    if([keyPath isEqualToString:kBBDecibelMeterAvgPowerKey]) {
        
        //NSLog(@"Power: %f, Peak: %f", self.meter.averagePower, self.meter.peakPower);
        dbPeakPowerValueLabel.text = [NSString stringWithFormat:@"%f",self.meter.peakPower];
        dbAveragePowerValueLabel.text = [NSString stringWithFormat:@"%f",self.meter.averagePower];
        
        [dbPeakPowerProgressView setProgress:self.meter.peakPower];
        [dbAveragePowerProgressView setProgress:self.meter.averagePower];
        
        [dbBarGauge resetPeak];
        dbBarGauge.value = self.meter.peakPower;
        dbBarGauge.value = self.meter.averagePower;
    }
}




- (IBAction)turnOnFingScanUrlButtonTouchUpInside:(id)sender{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://itunes.apple.com/app/fing-network-scanner/id430921107?mt=8"]];
}
- (IBAction)turnOnSpectViewUrlButtonTouchUpInside:(id)sender{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://itunes.apple.com/app/spectrumview/id472662922?mt=8"]];
}
- (IBAction)turnOnLightBlueUrlButtonTouchUpInside:(id)sender{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://itunes.apple.com/app/lightblue-bluetooth-low-energy/id557428110?mt=8"]];
}
- (IBAction)turnOnStopWatchUrlButtonTouchUpInside:(id)sender{
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:@"https://itunes.apple.com/app/bigstopwatch/id301615836?mt=8"]];
}


- (IBAction)fingTitleButtonTouchUpInside:(id)sender {
    [self popTipViewWithMessage:NSLocalizedString(@"DDFingAppDiscription", nil)
                       bySender:sender];
}

- (IBAction)spectViewTitleButtonTouchUpInside:(id)sender {
    [self popTipViewWithMessage:NSLocalizedString(@"DDSpectrumViewAppDiscription", nil)
                       bySender:sender];
}

- (IBAction)lightBlueTitleButtonTouchUpInside:(id)sender {
    [self popTipViewWithMessage:NSLocalizedString(@"DDLightBlueAppDiscription", nil)
                       bySender:sender];
}

- (IBAction)stopWatchTitleButtonTouchUpInside:(id)sender {
    [self popTipViewWithMessage:NSLocalizedString(@"DDBigStopWatchAppDiscription", nil)
                       bySender:sender];
}


- (void)popTipViewWithMessage:(NSString *)message bySender:(id)sender{
    [self dismissAllPopTipViews];
	
	if (sender == self.currentPopTipViewTarget) {
		// Dismiss the popTipView and that is all
		self.currentPopTipViewTarget = nil;
	}
	else {
		NSString *contentMessage = nil;
		UIView *contentView = nil;
		NSNumber *key = [NSNumber numberWithInteger:[(UIView *)sender tag]];
		contentMessage = message;
		
		NSArray *colorScheme = [self.colorSchemes objectAtIndex:6];
		UIColor *backgroundColor = [colorScheme objectAtIndex:0];
		UIColor *textColor = [colorScheme objectAtIndex:1];
		
		NSString *title = [self.titles objectForKey:key];
		
		CMPopTipView *popTipView;
		if (contentView) {
			popTipView = [[CMPopTipView alloc] initWithCustomView:contentView];
		}
		else if (title) {
			popTipView = [[CMPopTipView alloc] initWithTitle:title message:contentMessage];
		}
		else {
			popTipView = [[CMPopTipView alloc] initWithMessage:contentMessage];
		}
		popTipView.delegate = self;
		
		/* Some options to try.
		 */
		//popTipView.disableTapToDismiss = YES;
		//popTipView.preferredPointDirection = PointDirectionUp;
		//popTipView.hasGradientBackground = NO;
        //popTipView.cornerRadius = 2.0;
        //popTipView.sidePadding = 30.0f;
        //popTipView.topMargin = 20.0f;
        //popTipView.pointerSize = 50.0f;
        //popTipView.hasShadow = NO;
		
		if (backgroundColor && ![backgroundColor isEqual:[NSNull null]]) {
			popTipView.backgroundColor = backgroundColor;
		}
		if (textColor && ![textColor isEqual:[NSNull null]]) {
			popTipView.textColor = textColor;
		}
        
        popTipView.animation = YES;
		popTipView.has3DStyle = NO;
		
		popTipView.dismissTapAnywhere = YES;
        [popTipView autoDismissAnimated:YES atTimeInterval:8.0];
        
		if ([sender isKindOfClass:[UIButton class]]) {
			UIButton *button = (UIButton *)sender;
			[popTipView presentPointingAtView:button inView:self.view animated:YES];
		}
		else {
			UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
			[popTipView presentPointingAtBarButtonItem:barButtonItem animated:YES];
		}
		
		[self.visiblePopTipViews addObject:popTipView];
		self.currentPopTipViewTarget = sender;
	}
    
}

- (void)initPopTipView{
    self.visiblePopTipViews = [NSMutableArray array];
	
	
	self.titles = [NSDictionary dictionaryWithObjectsAndKeys:
				   @"Title", [NSNumber numberWithInt:14],
				   @"Auto Orientation", [NSNumber numberWithInt:12],
				   nil];
	
	// Array of (backgroundColor, textColor) pairs.
	// NSNull for either means leave as default.
	// A color scheme will be picked randomly per CMPopTipView.
	self.colorSchemes = [NSArray arrayWithObjects:
						 [NSArray arrayWithObjects:[NSNull null], [NSNull null], nil],            //NON Color
						 [NSArray arrayWithObjects:[UIColor colorWithRed:134.0/255.0 green:74.0/255.0 blue:110.0/255.0 alpha:1.0], [NSNull null], nil],
						 [NSArray arrayWithObjects:[UIColor darkGrayColor], [NSNull null], nil],
						 [NSArray arrayWithObjects:[UIColor lightGrayColor], [UIColor darkTextColor], nil],
						 [NSArray arrayWithObjects:[UIColor orangeColor], [UIColor blueColor], nil],
						 [NSArray arrayWithObjects:[UIColor colorWithRed:220.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0], [NSNull null], nil],
						 [NSArray arrayWithObjects:[UIColor colorWithRed:19.0/255.0 green:119.0/255.0 blue:61.0/255.0 alpha:0.9], [UIColor colorWithRed:225.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0], nil],
						 nil];
}


- (void)dismissAllPopTipViews
{
	while ([self.visiblePopTipViews count] > 0) {
		CMPopTipView *popTipView = [self.visiblePopTipViews objectAtIndex:0];
		[popTipView dismissAnimated:YES];
		[self.visiblePopTipViews removeObjectAtIndex:0];
	}
}
#pragma mark - CMPopTipViewDelegate methods

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
	[self.visiblePopTipViews removeObject:popTipView];
	self.currentPopTipViewTarget = nil;
}

@end







