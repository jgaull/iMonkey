//
//  DeviceView.m
//  iMonkey
//
//  Created by Jon on 1/3/15.
//  Copyright (c) 2015 Modeo. All rights reserved.
//

#import "DeviceView.h"

@interface DeviceView ()

@property (strong, nonatomic) PFImageView *deviceImage;

@property (nonatomic, strong) NSMutableArray *LEDImages;

@property (nonatomic) CGRect ledBoundingBox;
@property (nonatomic) NSInteger ledCount;

@end

@implementation DeviceView

- (void)renderLights {
    
    CGRect originalLEDSize = CGRectMake(0, 0, 42, 32);
    NSInteger visibleLEDCount = self.ledCount / 2;
    
    //float scale = self.deviceImage.image.scale;
    float scale = self.deviceImage.frame.size.width / self.deviceImage.image.size.width;
    
    CGRect scaledBoundingBox = CGRectMake(self.ledBoundingBox.origin.x * scale, self.ledBoundingBox.origin.y * scale, self.ledBoundingBox.size.width * scale, self.ledBoundingBox.size.height * scale);
    
    float LEDWidth = scaledBoundingBox.size.width;
    float LEDHeight = (LEDWidth / originalLEDSize.size.width) * originalLEDSize.size.height;
    
    float sizeDiff = scaledBoundingBox.size.height - LEDHeight * visibleLEDCount;
    float spacing = sizeDiff / (visibleLEDCount - 1);
    
    /*
    UIView *boundingBox = [[UIView alloc] initWithFrame:scaledBoundingBox];
    boundingBox.backgroundColor = [UIColor greenColor];
    [self addSubview:boundingBox];
     */
    
    for (int i = 0; i < self.ledCount / 2; i++) {
        CGRect lightFrame = CGRectMake(scaledBoundingBox.origin.x, scaledBoundingBox.origin.y + i * (LEDHeight + spacing), LEDWidth, LEDHeight);
        
        UIImageView *LEDImageView = [[UIImageView alloc] initWithFrame:lightFrame];
        LEDImageView.image = [UIImage imageNamed:@"white_light"];
        LEDImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.LEDImages addObject:LEDImageView];
        [self addSubview:LEDImageView];
    }
    
    [self drawPattern];
}

- (void)drawPattern {
    
    if (self.LEDImages.count == self.pattern.count) {
        for (int i = 0; i < self.LEDImages.count; i++) {
            BOOL lightState = [[_pattern objectAtIndex:i] boolValue];
            
            NSString *image;
            if (lightState) {
                image = @"red_light";
            }
            else {
                image = @"white_light";
            }
            
            UIImageView *ledImage = [self.LEDImages objectAtIndex:i];
            ledImage.image = [UIImage imageNamed:image];
        }
    }
}

- (void)setDevice:(PFObject *)device {
    
    if (_device != device) {
        
        NSDictionary *ledBoundingBoxDictionary = device[@"ledBoundingBox"];
        float x = [ledBoundingBoxDictionary[@"x"] floatValue];
        float y = [ledBoundingBoxDictionary[@"y"] floatValue];
        float width = [ledBoundingBoxDictionary[@"width"] floatValue];
        float height = [ledBoundingBoxDictionary[@"height"] floatValue];
        self.ledBoundingBox = CGRectMake(x, y, width, height);
        
        self.ledCount = [device[@"ledCount"] integerValue];
        
        self.deviceImage.file = device[@"thumbnail"];
        [self.deviceImage loadInBackground:^(UIImage *image, NSError *error) {
            if (error) {
                NSLog(@"error loading image.");
            }
            else {
                [self renderLights];
            }
        }];
        
        _device = device;
    }
}

- (void)setPattern:(NSArray *)pattern {
    if (pattern.count != self.ledCount / 2) {
        NSLog(@"not the correct number of leds in your pattern.");
    }
    else {
        _pattern = [NSArray arrayWithArray:pattern];
        [self drawPattern];
    }
}

- (PFImageView *)deviceImage {
    if (!_deviceImage) {
        _deviceImage = [[PFImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _deviceImage.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_deviceImage];
    }
    
    return _deviceImage;
}

- (NSMutableArray *)LEDImages {
    if (!_LEDImages) {
        _LEDImages = [NSMutableArray new];
    }
    return _LEDImages;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
