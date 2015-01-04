//
//  DeviceView.h
//  iMonkey
//
//  Created by Jon on 1/3/15.
//  Copyright (c) 2015 Modeo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface DeviceView : UIView

@property (strong, nonatomic) PFObject *device;

@end
