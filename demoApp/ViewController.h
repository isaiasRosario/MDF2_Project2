//
//  ViewController.h
//  demoApp
//
//  Created by Isaias Rosario on 8/13/14.
//  Copyright (c) 2014 Isaias Rosario. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

{
    NSMutableArray *twitterArr;

    IBOutlet UICollectionView *collectionView;
    
}

@end
