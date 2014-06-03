//
//  DDDateTimeDetailsViewController.h
//  Device Details
//
//  Created by Robert Yi Jiang on 03/6/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDDateTimeDetailsViewController : UIViewController
//Date Time
@property (strong, nonatomic) IBOutlet UILabel *localDateTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *utcDateTimeLabel;

@end
