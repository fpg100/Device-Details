//
//  DDHardwareDetailsViewController.h
//  Device Details
//
//  Created by Jingxi & Yi on 31/05/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>
//Hardware and OS Details
#include <sys/types.h>
#import <sys/sysctl.h>
#import <sys/utsname.h>
#import <mach/mach.h>
#define MB (1024*1024)
#define GB (MB*1024)

@interface DDHardwareDetailsViewController : UIViewController

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
@property (weak, nonatomic) IBOutlet UILabel *deviceDimentionsLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceWeightLabel;
@end
