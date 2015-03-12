//
//  ViewController.m
//  StacksExample
//
//  Created by Knotch on 2/17/15.
//  Copyright (c) 2015 knotch. All rights reserved.
//

#define ARRAY_OFFSET 3

#import "ViewController.h"
#import "UIView+Additions.h"
#import "UIColor+RandomColor.h"
#import "CollectionViewCell.h"

@interface ViewController ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, strong) NSArray *images;
@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    [self initData];
    [self initUI];
}


- (void)initData {
    _colors = @[].mutableCopy;
    for (int i = 0; i < 3; i++) {
        UIColor *randomColor = [UIColor randomColor];
        [_colors addObject:randomColor];
    }
    _images = @[@"penguin", @"panda", @"quokka"];
}

- (void)initUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setItemSize:CGSizeMake(self.view.width, self.view.height)];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [layout setMinimumInteritemSpacing:0];
    [layout setMinimumLineSpacing:0];
    [layout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    _collectionView = [[UICollectionView alloc]
                       initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,
                                                self.view.frame.size.height)
                       collectionViewLayout:layout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.alwaysBounceHorizontal = TRUE;
    _collectionView.alwaysBounceVertical = FALSE;
    _collectionView.showsHorizontalScrollIndicator = _collectionView.showsVerticalScrollIndicator = FALSE;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:[CollectionViewCell reuseIdentifier]];
    _collectionView.pagingEnabled = TRUE;
    _collectionView.scrollEnabled = FALSE;
    [self.view addSubview:_collectionView];
    
    self.arrayStacks = _colors;
    self.collectionViewStacks = _collectionView;
    self.arrayOffset = ARRAY_OFFSET;
}

#pragma mark - UICollectionView Methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CollectionViewCell reuseIdentifier] forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor clearColor];
    NSInteger index = indexPath.row;
    if (index < _colors.count) {
        UIColor *color = [_colors objectAtIndex:index];
        UIImage *image = [UIImage imageNamed:[_images objectAtIndex:index]];
        cell.label.backgroundColor = color;
        cell.label.text = [NSString stringWithFormat:@"Index %ld", index];
        cell.imageView.image = image;
    }
    else { // Offset cells - for extra data that is not in the array
        cell.label.backgroundColor = [UIColor randomColor];
        cell.label.text = [NSString stringWithFormat:@"Offset %ld", index];
        cell.imageView.image = nil;
        return cell;
    }
   return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_colors.count > 0) {
        return _colors.count + ARRAY_OFFSET;
    }
    else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

@end