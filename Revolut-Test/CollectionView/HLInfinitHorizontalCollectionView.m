//
//  HLInfinitHorizontalCollectionView.m
//  TestCollectionInfinit
//
//  Created by Кирилл Чуянов on 27.05.17.
//  Copyright © 2017 Кирилл Чуянов. All rights reserved.
//

#import "HLInfinitHorizontalCollectionView.h"
#import "HLHorizontalLayout.h"

@interface HLInfinitHorizontalCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation HLInfinitHorizontalCollectionView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    self.collectionViewLayout = [[HLHorizontalLayout alloc] init];
    [self _init];
  }
  
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
  if (self = [super initWithFrame:frame collectionViewLayout:[[HLHorizontalLayout alloc] init]]) {
    [self _init];
  }
  
  return self;
}

- (void)_init {
  self.dataSource = self;
  self.delegate = self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return [self.infinitDataSource numberOfItemsInInifinitCollectionView:self] + 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  NSInteger totalItems = [self.infinitDataSource numberOfItemsInInifinitCollectionView:self];
  
  NSInteger index = indexPath.item;
  if (index == 0) {
    index = totalItems - 1;
  } else if (index == (totalItems + 1)) {
    index = 0;
  } else {
    index -= 1;
  }
  
  return [self.infinitDataSource infinitCollectionView:self cellForDequedIndexPath:indexPath itemAtIndex:index];
}

- (void)scrollToFirstItem {
  
  CGRect visibleRect = CGRectMake(
                                  self.bounds.size.width,
                                  0,
                                  self.bounds.size.width,
                                  self.bounds.size.height
                                  );
  
  [self scrollRectToVisible:visibleRect animated:NO];
  
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  
  if ([self.infinitDataSource respondsToSelector:@selector(infinitCollectionView:didChangeCurrentPage:)]) {
    NSInteger totalItems = [self.infinitDataSource numberOfItemsInInifinitCollectionView:self];
    CGFloat index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    if (index <= 0) {
      index = totalItems - 1;
    } else if (index >= (totalItems + 1)) {
      index = 0;
    } else {
      index -= 1;
    }
    
    NSInteger i = (NSInteger)roundf(index);
  
  
    [self.infinitDataSource infinitCollectionView:self didChangeCurrentPage:i];
  }
  
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
  CGSize size = self.collectionViewLayout.collectionViewContentSize;
  
  if (scrollView.contentOffset.x <= 0) {
    
    CGRect visibleRect = CGRectMake(
                                    size.width - scrollView.bounds.size.width*2,
                                    0,
                                    scrollView.bounds.size.width,
                                    scrollView.bounds.size.height
                                    );
    [scrollView scrollRectToVisible:visibleRect animated:NO];
    
  } else if (scrollView.contentOffset.x >= (size.width - scrollView.bounds.size.width)) {
    
    CGRect visibleRect = CGRectMake(
                                    scrollView.bounds.size.width,
                                    0,
                                    scrollView.bounds.size.width,
                                    scrollView.bounds.size.height
                                    );
    
    [scrollView scrollRectToVisible:visibleRect animated:NO];
  }
}

@end
