//
//  DataViewController.m
//  iMonkey
//
//  Created by Jon on 12/20/14.
//  Copyright (c) 2014 Modeo. All rights reserved.
//

#import "ThemeViewController.h"
#import "LEDCodeView.h"
#import "DeviceView.h"

@interface ThemeViewController ()

@property (weak, nonatomic) IBOutlet DeviceView *deviceView;
@property (strong, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *thumbnailImageView;

@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *name = self.theme[@"name"];
    
    if (!name) {
        name = @"Pattern";
    }
    
    self.themeNameLabel.text = name;
    
    self.thumbnailImageView.file = self.theme[@"thumbnail"];
    [self.thumbnailImageView loadInBackground];
    
    PFObject *light = self.theme[@"light"];
    self.deviceView.device = light;
}

@end
