//
//  CollectionViewCell.h
//  NerdTimeStacks
//
//  Created by Knotch on 2/12/15.
//  Copyright (c) 2015 knotch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;

+ (NSString *)reuseIdentifier;

@end
