//
//  DDDateTimeDetailsViewController.m
//  Device Details
//
//  Created by Robert Yi Jiang on 03/6/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

#import "DDDateTimeDetailsViewController.h"

@interface DDDateTimeDetailsViewController ()

@end

@implementation DDDateTimeDetailsViewController

//Date Time
@synthesize localDateTimeLabel;
@synthesize utcDateTimeLabel;

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
    [self initDateTimeDetails];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


@end
