//
//  HLCurrencyCell.m
//  Revolut-Test
//
//  Created by Кирилл Чуянов on 27.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import "HLCurrencyCell.h"
#import "UICollectionView+HLCellRegistrator.h"

@interface HLCurrencyCell ()
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UILabel *toExchange;

- (void)updateExchange:(HLCurrencyCellModel*)model;

@end

@implementation HLCurrencyCellModel

- (instancetype)init {
  if (self = [super init]) {
    _amountForExchange = [[NSDecimalNumber alloc] initWithInt:0];
  }
  
  return self;
}

- (void)setTotalAmount:(NSDecimalNumber *)totalAmount {
  _totalAmount = totalAmount;
  
  if ([self.currentCell isKindOfClass:[HLCurrencyCell class]]) {
    [(HLCurrencyCell*)self.currentCell updateWithModel:self];
  }
}

- (void)setAmountForExchange:(NSDecimalNumber *)amountForExchange {
  _amountForExchange = amountForExchange;
  
  if ([self.currentCell isKindOfClass:[HLCurrencyCell class]]) {
    [(HLCurrencyCell*)self.currentCell updateExchange:self]; 
  }
}

- (UICollectionViewCell*)cellForCollectionView:(UICollectionView*)view atIndexPath:(NSIndexPath*)indexPath {
  
  HLCurrencyCell* cell =  [view dequeueReusableCellWithReuseIdentifier:[HLCurrencyCell reuseIdentifier] forIndexPath:indexPath];
  [cell updateWithModel:self];
  return cell;
}
@end



@implementation HLCurrencyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)updateWithModel:(HLCurrencyCellModel*)model {
  
  self.currencyLabel.text = model.currency;
  
  NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
  formatter.numberStyle = NSNumberFormatterCurrencyStyle;
  formatter.currencyCode = model.currency;
  formatter.minimumFractionDigits = 2;
  
  self.totalAmount.text = [NSString stringWithFormat:@"You have %@", [formatter stringFromNumber:model.totalAmount]];
  [self updateExchange:model];
  
  model.currentCell = self;
}

- (void)updateExchange:(HLCurrencyCellModel*)model {
  
  if (model.amountForExchange == nil) {
    self.toExchange.text = @"0";
    return;
  }
  
  NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
  formatter.numberStyle = NSNumberFormatterCurrencyStyle;
  formatter.currencyCode = model.currency;
  formatter.minimumFractionDigits = 2;
  
  self.toExchange.text = [NSString stringWithFormat:@"+ %@", [formatter stringFromNumber:model.amountForExchange]];
}

@end
