//
//  DDNetworkDetailsViewController.h
//  Device Details
//
//  Created by Robert Yi Jiang on 02/6/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

//Network Details
#include <sys/socket.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <net/if.h>
#include <dns.h>
#include <netinet/in.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "Reachability.h"
#import "BBDecibelMeter.h"
#import "ALSystem.h"

@interface DDNetworkDetailsViewController : UIViewController

//Network Details
@property (weak, nonatomic) IBOutlet UITextView *deviceUDIDtextField;
@property (weak, nonatomic) IBOutlet UILabel *networkTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssidLabel;
@property (weak, nonatomic) IBOutlet UILabel *publicIpAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *networkIpMaskLabel;
@property (weak, nonatomic) IBOutlet UILabel *macAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssidTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *routerIpAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *subnetMaskLabel;
@property (weak, nonatomic) IBOutlet UILabel *routerBoradcastAddrLabel;
@end
