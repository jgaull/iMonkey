//
//  LEDCodeView.m
//  iMonkey
//
//  Created by Jon on 12/20/14.
//  Copyright (c) 2014 Modeo. All rights reserved.
//

#import "LEDCodeView.h"

@implementation LEDCodeView

- (void)setCode:(NSArray *)code {
    _code = [NSArray arrayWithArray:code];
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGSize size = self.frame.size;
    
    int lineWidth = 4;
    
    NSUInteger length = self.code.count;
    float dotSize = size.width - lineWidth;
    float dotSpacing = 15;
    
    for (int i = 0; i < length; i++) {
        
        CGRect dotRect = CGRectMake(lineWidth / 2, i * (dotSize + dotSpacing) + lineWidth / 2, dotSize, dotSize);
        
        UIBezierPath *ledIndicator = [UIBezierPath bezierPathWithOvalInRect:dotRect];
        [[UIColor redColor] setFill];
        [[UIColor whiteColor] setStroke];
        ledIndicator.lineWidth = lineWidth;
        [ledIndicator stroke];
        [ledIndicator fill];
    }
    
}

@end
