//
//  HLCurrencyCell.h
//  Revolut-Test
//
//  Created by Кирилл Чуянов on 27.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLCollectionCompatible.h"

@class HLCurrencyCell;

@interface HLCurrencyCellModel : NSObject <HLCollectionCompatible>

@property (nonatomic, copy) NSDecimalNumber* totalAmount;
@property (nonatomic, copy) NSDecimalNumber* amountForExchange;
@property (nonatomic, copy) NSString* currency;

@property (nonatomic, strong) UICollectionViewCell* currentCell;

@end


@interface HLCurrencyCell : UICollectionViewCell

- (void)updateWithModel:(HLCurrencyCellModel*)model;

@end
