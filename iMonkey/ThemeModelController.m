//
//  ModelController.m
//  iMonkey
//
//  Created by Jon on 12/20/14.
//  Copyright (c) 2014 Modeo. All rights reserved.
//

#import "ThemeModelController.h"
#import "ThemeViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


@interface ThemeModelController ()

@property (strong, nonatomic) NSArray *themes;

@end

@implementation ThemeModelController

- (id)initWithThemes:(NSArray *)themes {
    self = [super init];
    if (self) {
        self.themes = [NSArray arrayWithArray:themes];
    }
    return self;
}

- (ThemeViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    // Return the data view controller for the given index.
    if (self.themes.count == 0 || index >= self.themes.count) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    ThemeViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.theme = self.themes[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(ThemeViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.themes indexOfObject:viewController.theme];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ThemeViewController *)viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(ThemeViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == self.themes.count) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
