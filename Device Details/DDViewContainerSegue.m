//
//  DDViewContainerSegue.m
//  Device Details
//
//  Created by Robert Yi Jiang on 29/5/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

#import "DDViewContainerSegue.h"
#import "DDMainViewController.h"

@implementation DDViewContainerSegue

- (void)perform
{
    DDMainViewController *mainViewController = (DDMainViewController *)self.sourceViewController;
    UIViewController *destinationViewController = (UIViewController *) mainViewController.destinationViewController;
    
    //remove old view controller
    if (mainViewController.oldViewController) {
        [mainViewController.oldViewController willMoveToParentViewController:nil];
        [mainViewController.oldViewController.view removeFromSuperview];
        [mainViewController.oldViewController removeFromParentViewController];
    }
    @try {
        destinationViewController.view.frame = mainViewController.detailsViewsContainer.bounds;
        [mainViewController addChildViewController:destinationViewController];
        [mainViewController.detailsViewsContainer addSubview:destinationViewController.view];
        [destinationViewController didMoveToParentViewController:mainViewController];
    }
    @catch (NSException *exception) {
        NSLog(@"exception :%@",exception);
    }
    @finally {
        
    }
   
}

@end
