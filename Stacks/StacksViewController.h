//
//  StacksViewController.h
//  StacksOnStacks
//
//  Created by Knotch on 3/17/14.
//  Copyright (c) 2014 knotch. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ScrollDirectionUnknown,
    ScrollDirectionNext,
    ScrollDirectionPrev
} ScrollDirection;

@interface StacksViewController : UIViewController <UIGestureRecognizerDelegate>

/***** Required *****/
// Set the array and the collectionview
// in order for Stacks to be useful
@property (nonatomic, strong) NSMutableArray *arrayStacks;
@property (nonatomic, strong) UICollectionView *collectionViewStacks;

/***** Optional *****/
// Set this number if the number of items
// is different than the array count
@property (nonatomic) NSInteger arrayOffset;

// You can access the current index of the collectionview
@property (nonatomic) NSInteger currentPage;
// You can disable swiping if need be
@property (nonatomic) BOOL swipeable;


@end
