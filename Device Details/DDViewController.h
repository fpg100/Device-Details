//
//  DDViewController.h
//  Device Details
//
//  Created by Robert Yi Jiang on 26/08/13.
//  Copyright (c) 2013 Robert Yi Jiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UILabel *deviceModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *osNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *osVersionLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceUDIDLabel;
@property (weak, nonatomic) IBOutlet UITextView *deviceUDIDtextField;
@property (weak, nonatomic) IBOutlet UILabel *networkTypeLabel;


@end
