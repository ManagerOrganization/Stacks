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
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:20];
        [self.contentView addSubview:_label];
    }
    return self;
}

+ (NSString *)reuseIdentifier {
    return @"CollectionViewCell";
}

@end
