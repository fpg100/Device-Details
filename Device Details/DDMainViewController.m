//
//  DDMainViewController.m
//  Device Details
//
//  Created by Jingxi & Yi on 2/01/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DDMainViewController.h"
#import "CMPopTipView.h"

@interface DDMainViewController (){
    NSMutableDictionary *_viewControllersByIdentifier;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation DDMainViewController
@synthesize adView;

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
    adView.delegate =self;
    
    NSLog(@"getSystemVersionAsAnInteger %d",[self getSystemVersionAsAnInteger]);
    if([self getSystemVersionAsAnInteger] < __IPHONE_7_0)
    {
        NSLog(@"getSystemVersionAsAnInteger < __IPHONE_7_0");
    } else {
        [self setNeedsStatusBarAppearanceUpdate];
    }
    _viewControllersByIdentifier = [NSMutableDictionary dictionary];
    
    
    RNLongPressGestureRecognizer *longPress = [[RNLongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [self.view addGestureRecognizer:longPress];
}

- (void)viewDidAppear:(BOOL)animated{
//    if (self.childViewControllers.count < 1) {
//        [self performSegueWithIdentifier:@"hardwareViewSegue" sender:self];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[_viewControllersByIdentifier allKeys] enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        if (![self.destinationIdentifier isEqualToString:key]) {
            [_viewControllersByIdentifier removeObjectForKey:key];
        }
    }];
}

-(void) bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"iAdBanner failed\n");
    NSLog(@"%@",[error localizedDescription]);
//    [adView setHidden:YES];
    
}
-(void) bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"iAdBanner loaded");
//    [adView setHidden:NO];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark - Target/Action

- (IBAction)onShowButton:(id)sender {
    [self showGrid];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        [self showGridWithHeaderFromPoint:[longPress locationInView:self.view]];
    }
}


#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    NSLog(@"before problem");
    NSLog(@"Dismissed with item %ld: %@", (long)itemIndex, item.title);
    @try {
    
        switch (itemIndex) {
            case 0:
                 [self performSegueWithIdentifier:@"HardwareViewSegue" sender:self];
                break;
            case 1:
                [self performSegueWithIdentifier:@"OperatingSystemViewSegue" sender:self];
                break;
            case 2:
                [self performSegueWithIdentifier:@"NetworkViewSegue" sender:self];
                break;
            case 3:
                [self performSegueWithIdentifier:@"DateTimeViewSegue" sender:self];
                break;
            case 4:
                [self performSegueWithIdentifier:@"BriefViewSegue" sender:self];
                break;
            case 5:
                [self performSegueWithIdentifier:@"CompassViewSegue" sender:self];
                break;
            case 6:
                [self performSegueWithIdentifier:@"MotionViewSegue" sender:self];
                break;
            case 7:
                [self performSegueWithIdentifier:@"LocationViewSegue" sender:self];
                break;
            case 8:
                [self performSegueWithIdentifier:@"BecibelMeterViewSegue" sender:self];
                break;
                
            default:
                break;
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"exception : %@",exception);
    }
    @finally {
        NSLog(@"Do nothing but back");
    }
}


#pragma mark - Private

- (void)showImagesOnly {
    NSInteger numberOfOptions = 5;
    NSArray *images = @[
                        [UIImage imageNamed:@"1393698288_menu-24"],
                        [UIImage imageNamed:@"attachment"],
                        [UIImage imageNamed:@"block"],
                        [UIImage imageNamed:@"bluetooth"],
                        [UIImage imageNamed:@"cube"],
                        [UIImage imageNamed:@"download"],
                        [UIImage imageNamed:@"enter"],
                        [UIImage imageNamed:@"file"],
                        [UIImage imageNamed:@"github"]
                        ];
    RNGridMenu *av = [[RNGridMenu alloc] initWithImages:[images subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

- (void)showList {
    NSInteger numberOfOptions = 5;
    NSArray *options = @[
                         @"Next",
                         @"Attach",
                         @"Cancel",
                         @"Bluetooth",
                         @"Deliver",
                         @"Download",
                         @"Enter",
                         @"Source Code",
                         @"Github"
                         ];
    RNGridMenu *av = [[RNGridMenu alloc] initWithTitles:[options subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    //    av.itemTextAlignment = NSTextAlignmentLeft;
    av.itemFont = [UIFont boldSystemFontOfSize:18];
    av.itemSize = CGSizeMake(150, 55);
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

- (void)showGrid {
    NSInteger numberOfOptions = 9;
    NSArray *items = @[
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"Chip"] title:@"Hardware"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"AppleLogo"] title:@"OS"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"1393698864_cloud"] title:@"Network"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"Calendar"] title:@"Date Time"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"note"] title:@"Brief Info."],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"compass-512"] title:@"Compass"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"1393698827_vynil"] title:@"Motion"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"1393698839_location"] title:@"Location"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"1393698752_sound"] title:@"Decibel Meter"]
                       ];
    
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    //    av.bounces = NO;
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

- (void)showGridWithHeaderFromPoint:(CGPoint)point {
    NSInteger numberOfOptions = 9;
    NSArray *items = @[
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"radio"] title:@"Broadcast"],
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"back-alt"] title:@"Back"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"camera"] title:@"Camera"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"paperplane"] title:@"Forward"],
                       [RNGridMenuItem emptyItem],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"file"] title:@"Source Code"],
                       [RNGridMenuItem emptyItem]
                       ];
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    av.bounces = NO;
    av.animationDuration = 0.3;
    av.blurExclusionPath = [UIBezierPath bezierPathWithOvalInRect:self.imageView.frame];
    av.backgroundPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0.f, 0.f, av.itemSize.width*3, av.itemSize.height*3)];
    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 44)];
    header.text = @"Example Header";
    header.font = [UIFont boldSystemFontOfSize:18];
    header.backgroundColor = [UIColor clearColor];
    header.textColor = [UIColor whiteColor];
    header.textAlignment = NSTextAlignmentCenter;
    // av.headerView = header;
    
    [av showInViewController:self center:point];
}

- (void)showGridWithPath {
    NSInteger numberOfOptions = 9;
    NSArray *items = @[
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"arrow"] title:@"Next"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"attachment"] title:@"Attach"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"block"] title:@"Cancel"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"bluetooth"] title:@"Bluetooth"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"cube"] title:@"Deliver"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"download"] title:@"Download"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"enter"] title:@"Enter"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"file"] title:@"Source Code"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"github"] title:@"Github"]
                       ];
    
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[items subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    //    av.bounces = NO;
    [av showInViewController:self center:CGPointMake(self.view.bounds.size.width/2.f, self.view.bounds.size.height/2.f)];
}

- (NSInteger) getSystemVersionAsAnInteger{
    int index = 0;
    NSInteger version = 0;
    
    NSArray* digits = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    NSEnumerator* enumer = [digits objectEnumerator];
    NSString* number;
    while (number = [enumer nextObject]) {
        if (index>2) {
            break;
        }
        NSInteger multipler = powf(100, 2-index);
        version += [number intValue]*multipler;
        index++;
    }
    return version;
}





#pragma mark - Customize View Segue
#pragma mark -
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (![segue isKindOfClass:[DDViewContainerSegue class]]) {
        [super prepareForSegue:segue sender:sender];
        return;
    }
    
    self.oldViewController = self.destinationViewController;
    
    //if view controller isn't already contained in the viewControllers-Dictionary
    if (![_viewControllersByIdentifier objectForKey:segue.identifier]) {
        [_viewControllersByIdentifier setObject:segue.destinationViewController forKey:segue.identifier];
    }
    
    self.destinationIdentifier = segue.identifier;
    self.destinationViewController = [_viewControllersByIdentifier objectForKey:self.destinationIdentifier];
    
}


#pragma mark - Navigation


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    self.destinationViewController.view.frame = self.detailsViewsContainer.bounds;
}

@end
