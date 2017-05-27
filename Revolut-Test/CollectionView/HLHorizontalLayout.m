//
//  HLHorizontalLayout.m
//  TestCollectionInfinit
//
//  Created by Кирилл Чуянов on 27.05.17.
//  Copyright © 2017 Кирилл Чуянов. All rights reserved.
//

#import "HLHorizontalLayout.h"

@interface HLHorizontalLayout ()
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes*>* cache;
@end

@implementation HLHorizontalLayout

- (void)prepareLayout {
  
  if (_cache == nil) {
    _cache = [[NSMutableArray alloc] init];
    
    
    CGFloat cellWidth = self.collectionView.bounds.size.width;
    CGFloat cellHeight = self.collectionView.bounds.size.height;
    
    for (int i =0; i < [self.collectionView numberOfItemsInSection:0]; ++i) {
      
      CGRect frame = CGRectMake(i * cellWidth, 0, cellWidth, cellHeight);
      
      NSIndexPath* indexPath = [NSIndexPath indexPathForItem:i inSection:0];
      
      UICollectionViewLayoutAttributes* attrs =  [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
      attrs.frame = frame;
      
      [_cache addObject:attrs];
      
    }
  }
  
}

- (CGSize)collectionViewContentSize {
  return CGSizeMake(
                    self.collectionView.bounds.size.width * [self.collectionView numberOfItemsInSection:0],
                    self.collectionView.bounds.size.height
                    );
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
  
  NSMutableArray<UICollectionViewLayoutAttributes*>* result = [[NSMutableArray alloc] init];
  
  for (int i = 0; i < self.cache.count; ++i) {
    if (CGRectIntersectsRect(rect, self.cache[i].frame) == YES) {
      [result addObject:self.cache[i]];
    }
  }
  
  return result.copy;
}

- (void)invalidateLayout {
  _cache = nil;
  [super invalidateLayout];
}

@end
