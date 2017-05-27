//
//  UICollectionView+HLCellRegistrator.h
//  Revolut-Test
//
//  Created by Кирилл Чуянов on 27.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLReusableCell.h"

@interface UICollectionView (HLCellRegistrator) <HLReusableCellRegistrator>

@end

@interface UICollectionViewCell (HLReusableCell) <HLReusableCell>

@end
