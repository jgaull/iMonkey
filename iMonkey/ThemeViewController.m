//
//  DataViewController.m
//  iMonkey
//
//  Created by Jon on 12/20/14.
//  Copyright (c) 2014 Modeo. All rights reserved.
//

#import "ThemeViewController.h"
#import "LEDCodeView.h"

@interface ThemeViewController ()

@property (weak, nonatomic) IBOutlet PFImageView *monkeylightHardwareImage;
@property (strong, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *thumbnailImageView;
@property (weak, nonatomic) IBOutlet LEDCodeView *codeView;

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
    
    self.monkeylightHardwareImage.file = self.theme[@"light"][@"thumbnail"];
    [self.monkeylightHardwareImage loadInBackground];
    
    self.codeView.code = @[[NSNumber numberWithBool:1],
                           [NSNumber numberWithBool:0],
                           [NSNumber numberWithBool:1],
                           [NSNumber numberWithBool:1],
                           [NSNumber numberWithBool:0],
                           [NSNumber numberWithBool:1]];
}

@end
