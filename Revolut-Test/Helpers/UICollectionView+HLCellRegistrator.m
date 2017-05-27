//
//  UICollectionView+HLCellRegistrator.m
//  Revolut-Test
//
//  Created by Кирилл Чуянов on 27.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import "UICollectionView+HLCellRegistrator.h"

@implementation UICollectionView (HLCellRegistrator)

- (void)registerCell:(Class<HLReusableCell>)cell {

  [self registerNib:[cell nib] forCellWithReuseIdentifier:[cell reuseIdentifier]];
  
}

@end

@implementation UICollectionViewCell (HLReusableCell)

+ (UINib *)nib {
  return [UINib nibWithNibName:NSStringFromClass(self) bundle:nil];
}

+ (NSString *)reuseIdentifier {
  return NSStringFromClass(self);
}

@end
