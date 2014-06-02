//
//  DDOSDetailsViewController.h
//  Device Details
//
//  Created by Robert Yi Jiang on 02/6/2014.
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

@interface DDOSDetailsViewController : UIViewController

//OS Details
@property (weak, nonatomic) IBOutlet UILabel *osNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *osVersionLabel;
@property (weak, nonatomic) IBOutlet UILabel *osJailbrokenLabel;

@end
