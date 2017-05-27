//
//  HLInfinitHorizontalCollectionView.h
//  TestCollectionInfinit
//
//  Created by Кирилл Чуянов on 27.05.17.
//  Copyright © 2017 Кирилл Чуянов. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HLInfinitHorizontalCollectionView;

@protocol HLInfinitHorizontalCollectionViewDataSource <NSObject>

- (NSInteger)numberOfItemsInInifinitCollectionView:(HLInfinitHorizontalCollectionView*)view;
- (UICollectionViewCell*)infinitCollectionView:(HLInfinitHorizontalCollectionView*)view cellForDequedIndexPath:(NSIndexPath*)indexPath itemAtIndex:(NSInteger)index;
@optional
- (void)infinitCollectionView:(HLInfinitHorizontalCollectionView*)view didChangeCurrentPage:(NSInteger)index;

@end

@interface HLInfinitHorizontalCollectionView : UICollectionView
@property (nonatomic, weak) id<HLInfinitHorizontalCollectionViewDataSource> infinitDataSource;
- (void)scrollToFirstItem;
@end
