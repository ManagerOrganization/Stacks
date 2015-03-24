//
//  StacksViewController.m
//  StacksOnStacks
//
//  Copyright © 2014, 2015 Knotch, Inc.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
//  Software, and to permit persons to whom the Software is furnished to do so, subject
//  to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#define animationTime 0.2f
#import "StacksViewController.h"
#import "UIView+Snapshot.h"

@interface StacksViewController () {
    UIPanGestureRecognizer *_panGesture;
    BOOL navigated;
    CGFloat initialX, initialVelocity;
    
    ScrollDirection _scrollDirection;
    UIImageView *_snapshotView;
    UIImageView *_currentSnapshot;
}

@end

@implementation StacksViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _arrayOffset = 0;
        _swipeable = TRUE;
        navigated = FALSE;
        _currentPage = initialX = initialVelocity = 0;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    [_panGesture setDelegate:self];
    [self.view addGestureRecognizer:_panGesture];
}

#pragma mark - Gesture Holder methods
/***** IMPORTANT *****/
// gestureRecognizerShouldBegin should only reside in this uiviewcontroller
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:self.view];
    _scrollDirection = ScrollDirectionUnknown;
    if (navigated || !_swipeable) {
        return NO;
    }
    if (abs(translation.x) + 5.0f > abs(translation.y)) {
        //Do not let a swipe happen out of bounds
        if ((translation.x < 0 && _currentPage >= _arrayStacks.count + _arrayOffset - 1)
            || (translation.x > 0 && _currentPage < 1)){
            return NO;
        }
        initialX = translation.x;
        return YES;
    }
    return NO;
}
// Determines the direction of the pan gesture
- (CGFloat)determineScrollDirection:(CGFloat)translation{
    CGFloat diffX = translation - initialX;
    if (diffX < 0.0f && translation != 0.0f) {
        _scrollDirection = ScrollDirectionNext;
        _currentSnapshot = [[UIImageView alloc] initWithImage:[self.view imageFromView]];
        [_currentSnapshot setFrame:self.view.bounds];
        [self.view addSubview:_currentSnapshot];
    }
    else if(diffX > 0.0f && translation != 0.0f) { //CHECK
        _scrollDirection = ScrollDirectionPrev;
        if (_currentPage > 0) {
            _currentSnapshot = [[UIImageView alloc] initWithImage:[self.view imageFromView]];
            [_currentSnapshot setFrame:self.view.bounds];
            [self.view addSubview:_currentSnapshot];
            _currentPage--;
            [self scrollToCurrentPage];
            _collectionViewStacks.frame = CGRectMake(-1 * _collectionViewStacks.frame.size.width,
                                                     0,
                                                     _collectionViewStacks.frame.size.width,
                                                     _collectionViewStacks.frame.size.height);
            [self.view bringSubviewToFront:_collectionViewStacks];
        }
    }
    else{
        _scrollDirection = ScrollDirectionUnknown;
        
    }
    return diffX;
    
}
- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender {
    CGPoint translate = [sender translationInView:self.view];
    CGFloat boundsW = CGRectGetWidth(self.view.bounds);
    CGFloat boundsH = CGRectGetHeight(self.view.bounds);
    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            CGFloat velocityX = [sender velocityInView:self.view].x;
            initialVelocity = fabsf(velocityX);
            [self determineScrollDirection:translate.x];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            switch (_scrollDirection) {
                case ScrollDirectionUnknown:{
                    //Determine Scroll Direction
                    [self determineScrollDirection:translate.x];
                    break;
                }
                case ScrollDirectionNext:{
                    //Handle as Forward
                    if (!navigated) {
                        navigated = TRUE;
                        _currentPage++;
                        [self scrollToCurrentPage];
                    }
                    if (translate.x <= 0) {
                        CGRect newRect = CGRectMake(translate.x, 0, boundsW, boundsH);
                        [_currentSnapshot setFrame:newRect];
                    }
                    else {
                        CGRect newRect = CGRectMake(0, 0, boundsW, boundsH);
                        [_currentSnapshot setFrame:newRect];
                    }
                    
                    break;
                }
                case ScrollDirectionPrev:{
                    //Handle as Backward
                    if (!navigated) {
                        navigated = TRUE;
                    }
                    CGFloat tempX = -1 * self.view.frame.size.width + translate.x;
                    if (tempX <= 0) {
                        CGRect newRect = CGRectMake(tempX, 0, boundsW, boundsH);
                        [_collectionViewStacks setFrame:newRect];
                    }
                    else {
                        CGRect newRect = CGRectMake(0, 0, boundsW, boundsH);
                        [_collectionViewStacks setFrame:newRect];
                    }
                    break;
                }
                default:
                    break;
            }
            
        }
        case UIGestureRecognizerStateCancelled : {
            break;
        }
        case UIGestureRecognizerStateEnded: {
            if (_scrollDirection == ScrollDirectionNext) {
                if (_currentSnapshot.frame.origin.x + _currentSnapshot.frame.size.width
                    > self.view.frame.size.width / 2 && initialVelocity < 300) {  // Reverse everything!
                    [UIView animateWithDuration:animationTime animations:^{
                        CGRect newRect = CGRectMake(0, 0, boundsW, boundsH);
                        [_currentSnapshot setFrame:newRect];
                    } completion:^(BOOL finished) {
                        _currentPage--;
                        [self scrollToCurrentPage];
                        [_currentSnapshot removeFromSuperview];
                        navigated = FALSE;
                    }];
                }
                else {
                    [UIView animateWithDuration:animationTime animations:^{
                        CGRect newRect = CGRectMake(-boundsW, 0, boundsW, boundsH);
                        [_currentSnapshot setFrame:newRect];
                    } completion:^(BOOL finished) {
                        [_currentSnapshot removeFromSuperview];
                        navigated = FALSE;
                    }];
                }
            }
            else if (_scrollDirection == ScrollDirectionPrev) {
                if (_collectionViewStacks.center.x < 0  && initialVelocity < 300) { // Reverse everything!
                    [UIView animateWithDuration:animationTime animations:^{
                        CGRect newRect = CGRectMake(-boundsW, 0, boundsW, boundsH);
                        [_collectionViewStacks setFrame:newRect];
                    } completion:^(BOOL finished) {
                        _currentPage++;
                        [self scrollToCurrentPage];
                        [self.view bringSubviewToFront:_currentSnapshot];
                        CGRect newRect = CGRectMake(0, 0, boundsW, boundsH);
                        _collectionViewStacks.frame = newRect;
                        [_currentSnapshot removeFromSuperview];
                        navigated = FALSE;
                    }];
                }
                else {
                    [UIView animateWithDuration:animationTime animations:^{
                        CGRect newRect = CGRectMake(0, 0, boundsW, boundsH);
                        _collectionViewStacks.frame = newRect;
                    } completion:^(BOOL finished) {
                        [_currentSnapshot removeFromSuperview];
                        navigated = FALSE;
                    }];
                }
            }
            break;
        }
        default:
            [_currentSnapshot removeFromSuperview];
            break;
    }
}
-(void)scrollToCurrentPage{
    if(_currentPage >= 0 && _currentPage <= _arrayStacks.count + _arrayOffset - 1){
        [_collectionViewStacks scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_currentPage inSection:0]
                                      atScrollPosition:UICollectionViewScrollPositionNone animated:FALSE];
    }
    else{
        NSLog(@"Trying to scroll out of bounds. Not gonna happen");
    }
}
@end
