//
//  TodayViewController.h
//  DD Widget
//
//  Created by Robert Yi Jiang on 07/7/2015.
//  Copyright (c) 2015 Robert Yi Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>


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

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <resolv.h>

@interface TodayViewController : UIViewController
- (IBAction)buttonTouchUpInSide:(id)sender;

//Network Details
@property (weak, nonatomic) IBOutlet UILabel *networkTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *externalIpAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *ipAddrLabel;
@property (weak, nonatomic) IBOutlet UILabel *networkIpMaskLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssidTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *ssidLabel;
@end
