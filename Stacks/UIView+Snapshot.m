//
//  UIView+Snapshot.m
//  StacksOnStacks
//
//  Created by Knotch on 3/17/14.
//  Copyright (c) 2014 knotch. All rights reserved.
//

#import "UIView+Snapshot.h"
#import "UIViewAdditions.h"

@implementation UIView (Snapshot)

#pragma mark - Screen Snapshot

- (UIImage *)makeImageFromCurrentView {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.centerX, self.centerY);
    CGContextConcatCTM(context, self.transform);
    CGContextTranslateCTM(context, -1 * self.width * self.layer.anchorPoint.x, -1 * self.height * self.layer.anchorPoint.y);
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    } else {
        [self.layer renderInContext:context];
    }
    CGContextRestoreGState(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
