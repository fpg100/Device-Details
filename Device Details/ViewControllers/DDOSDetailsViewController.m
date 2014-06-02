//
//  DDOSDetailsViewController.m
//  Device Details
//
//  Created by Robert Yi Jiang on 02/6/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

#import "DDOSDetailsViewController.h"
#import "ALSystem.h"

@interface DDOSDetailsViewController ()

@end

@implementation DDOSDetailsViewController

//OS Details
@synthesize osNameLabel;
@synthesize osVersionLabel;
@synthesize osJailbrokenLabel;


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
    [self getOSDetails];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getOSDetails{
    
    osNameLabel.text = [UIDevice currentDevice].systemName;
    osVersionLabel.text = [UIDevice currentDevice].systemVersion;
    osJailbrokenLabel.text = [NSString stringWithFormat:@"%@",([ALJailbreak isJailbroken]?@"YES":@"NO")];
    NSLog(@"Name: %@",[UIDevice currentDevice].name);
    NSLog(@"description: %@",[UIDevice currentDevice].description);
    NSLog(@"debugDescription: %@",[UIDevice currentDevice].debugDescription);
    NSLog(@"hash: %d",[UIDevice currentDevice].hash);
    NSLog(@"model: %@",[UIDevice currentDevice].model);
    NSLog(@"localizedModel: %@",[UIDevice currentDevice].localizedModel);
//    NxSLog(@"version: %d",[UIDevice currentDevice].version);
    
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

@end
