//
//  NTCollectionViewCell.m
//  NerdTimeStacks
//
//  Created by Knotch on 2/12/15.
//  Copyright (c) 2015 knotch. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_imageView];
    
    _label = [[UILabel alloc] initWithFrame:self.bounds];
    _label.textColor = [UIColor blackColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
    _label.alpha = 0.7;
    [self.contentView addSubview:_label];
}

+ (NSString *)reuseIdentifier {
    return @"CollectionViewCell";
}

@end
