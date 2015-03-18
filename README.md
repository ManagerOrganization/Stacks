#Stacks

Have you ever wondered how Feedly's app manages to make its feed look like a stack of cards? We have, and Stacks is what we came up with.

Stacks is a preview-able card view. As you're scrolling through, you are able to see a preview of the next or previous card. 


![Stacks](http://i.imgur.com/paQ61PI.gif)


##Assumptions 
(If you run into any problems, first check the following list)
This project assumes the following:
- You are using a UICollectionView.
- The UICollectionViewCell takes up the whole screen.
- UICollectionView's scrolling is disabled.

##How
- Drag and drop the 'Stacks' folder into your project
- In the UIViewController that houses the UICollectionView, #import "StacksViewController.h" and change the base class from 'UIViewController' to 'StacksViewController'
- Point your array and collectionview to self.arrayStacks and self.collectionViewStacks = _collectionView respectively.
- Voila, you're all set.


##Extras 
arrayOffset: If you are showing items in addition to the ones in the array, use this integer.
NSInteger currentPage: If you want to find out which index/page the collectionView is on, use this integer.
BOOL swipeable: If you want to disable swiping all together, use this boolean.

##License
Copyright © 2014, 2015 Knotch, Inc.
 
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

