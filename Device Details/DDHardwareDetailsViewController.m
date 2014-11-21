//
//  DDHardwareDetailsViewController.m
//  Device Details
//
//  Created by Jingxi & Yi on 31/05/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

#import "DDHardwareDetailsViewController.h"
#import "ALSystem.h"

@interface DDHardwareDetailsViewController ()

@end

@implementation DDHardwareDetailsViewController

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
    
    [self getDeviceDetails];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if ([platform isEqualToString:@"iPhone3,1"])    deviceTypeLabel.text = @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,2"])    deviceTypeLabel.text = @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])    deviceTypeLabel.text = @"iPhone 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])    deviceTypeLabel.text = @"iPhone 4S (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,1"])    deviceTypeLabel.text = @"iPhone 5 (LTE)";
    if ([platform isEqualToString:@"iPhone5,2"])    deviceTypeLabel.text = @"iPhone 5 (LTE+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    deviceTypeLabel.text = @"iPhone 5c (LTE)";
    if ([platform isEqualToString:@"iPhone5,4"])    deviceTypeLabel.text = @"iPhone 5c (LTE+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    deviceTypeLabel.text = @"iPhone 5s (LTE)";
    if ([platform isEqualToString:@"iPhone6,2"])    deviceTypeLabel.text = @"iPhone 5s (LTE+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    deviceTypeLabel.text = @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    deviceTypeLabel.text = @"iPhone 6";
    
    if ([platform isEqualToString:@"iPod1,1"])      deviceTypeLabel.text = @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      deviceTypeLabel.text = @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      deviceTypeLabel.text = @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      deviceTypeLabel.text = @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      deviceTypeLabel.text = @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])      deviceTypeLabel.text = @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      deviceTypeLabel.text = @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      deviceTypeLabel.text = @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      deviceTypeLabel.text = @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      deviceTypeLabel.text = @"iPad 2 (WiFi) Mid 2012";
    if ([platform isEqualToString:@"iPad2,5"])      deviceTypeLabel.text = @"iPad Mini (WiFi) 2012";
    if ([platform isEqualToString:@"iPad2,6"])      deviceTypeLabel.text = @"iPad Mini (LTE) 2012";
    if ([platform isEqualToString:@"iPad2,7"])      deviceTypeLabel.text = @"iPad Mini (LTE+CDMA) 2012";
    if ([platform isEqualToString:@"iPad3,1"])      deviceTypeLabel.text = @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      deviceTypeLabel.text = @"iPad 3 (LTE+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      deviceTypeLabel.text = @"iPad 3 (LTE)";
    if ([platform isEqualToString:@"iPad3,4"])      deviceTypeLabel.text = @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      deviceTypeLabel.text = @"iPad 4 (LTE)";
    if ([platform isEqualToString:@"iPad3,6"])      deviceTypeLabel.text = @"iPad 4 (LTE+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      deviceTypeLabel.text = @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      deviceTypeLabel.text = @"iPad Air (LTE)";
    if ([platform isEqualToString:@"iPad4,4"])      deviceTypeLabel.text = @"iPad Mini 2 (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      deviceTypeLabel.text = @"iPad Mini 2 (LTE)";
    if ([platform isEqualToString:@"iPad4,6"])      deviceTypeLabel.text = @"iPad Mini 2 (LTE)";
    if ([platform isEqualToString:@"iPad4,7"])      deviceTypeLabel.text = @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])      deviceTypeLabel.text = @"iPad Mini 3 (LTE)";
    if ([platform isEqualToString:@"iPad4,9"])      deviceTypeLabel.text = @"iPad Mini 3 (LTE)";
    if ([platform isEqualToString:@"iPad5,3"])      deviceTypeLabel.text = @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])      deviceTypeLabel.text = @"iPad Air 2 (LTE)";
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
    
//    osNameLabel.text = [UIDevice currentDevice].systemName;
//    osVersionLabel.text = [UIDevice currentDevice].systemVersion;
//    osJailbrokenLabel.text = [NSString stringWithFormat:@"%@",([ALJailbreak isJailbroken]?@"YES":@"NO")];
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


@end
