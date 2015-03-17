#Stacks

Have you ever wondered how Feedly app manages to make its feed look like a stack of cards? We have, and Stacks is what we came up with.

Stacks is a some awesome description of what it is.

![Stacks](http://i.imgur.com/paQ61PI.gif)

##How
- Drag and drop the 'Stacks' folder into your project
- In the UIViewController that houses the UICollectionView, #import "StacksViewController.h" and change the base class from 'UIViewController' to 'StacksViewController'
- Point your array and collectionview to self.arrayStacks and self.collectionViewStacks = _collectionView respectively.
- Voila, you're all set.



