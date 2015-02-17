//
//  UIView+Snapshot.m
//  StacksOnStacks
//
//  Created by Knotch on 3/17/14.
//  Copyright (c) 2014 knotch. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)

#pragma mark - Screen Snapshot

- (UIImage *)makeImageFromCurrentView {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.center.x, self.center.y);
    CGContextConcatCTM(context, self.transform);
    CGContextTranslateCTM(context, -1 * self.frame.size.width * self.layer.anchorPoint.x, -1 * self.frame.size.height * self.layer.anchorPoint.y);
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
