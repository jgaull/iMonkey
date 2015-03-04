//
//  ProductGalleryCollectionViewController.m
//  iMonkey
//
//  Created by Jon on 1/19/15.
//  Copyright (c) 2015 Modeo. All rights reserved.
//

#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

#import "ProductGalleryCollectionViewController.h"
#import "ThemeCollectionViewCell.h"

@interface ProductGalleryCollectionViewController ()

@property (strong, nonatomic) NSArray *themes;

@end

@implementation ProductGalleryCollectionViewController

static NSString * const reuseIdentifier = @"ThemeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    PFObject *light = [PFObject objectWithoutDataWithClassName:@"Light" objectId:@"asZchupARE"];
    
    PFQuery *query = [[PFQuery alloc] initWithClassName:@"Pattern"];
    [query whereKey:@"light" equalTo:light];
    [query includeKey:@"light"];
    [query orderByAscending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error) {
            NSLog(@"error loading patterns");
        }
        else {
            self.themes = [[NSArray alloc] initWithArray:objects];
            
            [self.collectionView reloadData];
            
            NSLog(@"loaded %lu objects.", (unsigned long)objects.count);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.themes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    
    // Configure the cell
    /*
    PFObject *theme = self.themes[indexPath.row];
    PFFile *thumbnailFile = theme[@"thumbnail"];
    cell.thumb.file = thumbnailFile;
    [cell.thumb loadInBackground];
     */
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
