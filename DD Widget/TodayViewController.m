//
//  TodayViewController.m
//  DD Widget
//
//  Created by Robert Yi Jiang on 07/7/2015.
//  Copyright (c) 2015 Robert Yi Jiang. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "ALSystem.h"

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController

//Network Details
@synthesize networkTypeLabel;
@synthesize externalIpAddrLabel;
@synthesize ipAddrLabel;
@synthesize networkIpMaskLabel;
@synthesize ssidLabel;
@synthesize ssidTagLabel;

Reachability *googleReach;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (IBAction)buttonTouchUpInSide:(id)sender {
    NSLog(@"Yes....!!");
    
    [self getNetworkDetails];
}


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
    
    [self updatePublicIP];
    NSString *ipAddressString = [self getIPAddress];
    NSString *networkIpMaskString = [ALNetwork WiFiNetmaskAddress];
    //        [self getDnsServers];
    ipAddrLabel.text = ipAddressString;
    networkIpMaskLabel.text = networkIpMaskString;
    
    
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
            networkTypeLabel.text = @"Celullar";
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

@end
