//
//  HLCurrencyInputCell.h
//  Revolut-Test
//
//  Created by Кирилл Чуянов on 27.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLCurrencyCell.h"

@class HLCurrencyInputCellModel;

@protocol HLCurrencyInputCellModelDelegate <NSObject>
- (void)currencyInputModelChanged:(HLCurrencyInputCellModel*)model;
@end

@interface HLCurrencyInputCellModel : HLCurrencyCellModel
@property (nonatomic, weak) id<HLCurrencyInputCellModelDelegate> delegate;
- (void)setCurrentInput;
@end

@interface HLCurrencyInputCell : UICollectionViewCell
- (void)updateWithModel:(HLCurrencyInputCellModel*)model;
@end
