//
//  ModelController.h
//  iMonkey
//
//  Created by Jon on 12/20/14.
//  Copyright (c) 2014 Modeo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ThemeViewController;

@interface ThemeModelController : NSObject <UIPageViewControllerDataSource>

- (id)initWithThemes:(NSArray *)patterns;

- (ThemeViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(ThemeViewController *)viewController;

@end

