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

@property (nonatomic, strong) NSMutableArray *arrayStacks;
@property (nonatomic, strong) UICollectionView *collectionViewStacks;
@property (nonatomic) NSInteger arrayOffset, currentPage;
@property (nonatomic) BOOL swipeable;


@end
