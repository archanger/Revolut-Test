//
//  HLCurrencyInputCell.m
//  Revolut-Test
//
//  Created by Кирилл Чуянов on 27.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import "HLCurrencyInputCell.h"
#import "UICollectionView+HLCellRegistrator.h"

@interface HLCurrencyInputCell ()
@property (weak, nonatomic) IBOutlet UILabel *currencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountlabel;
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@property (nonatomic, weak) HLCurrencyInputCellModel* model;
@end


@implementation HLCurrencyInputCellModel

- (void)setAmountForExchange:(NSDecimalNumber *)amountForExchange {
  [super setAmountForExchange:amountForExchange];
  
  [self.delegate currencyInputModelChanged:self];
}

- (void)setTotalAmount:(NSDecimalNumber *)totalAmount {
  [super setTotalAmount:totalAmount];
  
  if ([self.currentCell isKindOfClass:[HLCurrencyInputCell class]]) {
    [(HLCurrencyInputCell*)self.currentCell updateWithModel:self];
  }
}

- (UICollectionViewCell *)cellForCollectionView:(UICollectionView *)view atIndexPath:(NSIndexPath *)indexPath {
  HLCurrencyInputCell* cell = [view dequeueReusableCellWithReuseIdentifier:[HLCurrencyInputCell reuseIdentifier] forIndexPath:indexPath];
  [cell updateWithModel:self];
  return cell;
}

- (void)setCurrentInput {
  if ([self.currentCell isKindOfClass:[HLCurrencyInputCell class]]) {
    [((HLCurrencyInputCell*)self.currentCell).inputField resignFirstResponder];
  }
}

@end


@implementation HLCurrencyInputCell

- (void)awakeFromNib {
  [super awakeFromNib];
  
  [self.inputField addTarget:self action:@selector(textfieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)updateWithModel:(HLCurrencyInputCellModel *)model {
  
  NSNumberFormatter* formatter = [[NSNumberFormatter alloc] init];
  formatter.numberStyle = NSNumberFormatterCurrencyStyle;
  formatter.currencyCode = model.currency;
  formatter.minimumFractionDigits = 2;
  
  self.amountlabel.text = [NSString stringWithFormat:@"You have %@", [formatter stringFromNumber:model.totalAmount]];
  self.currencyLabel.text = model.currency;
  self.inputField.text = @"0";
  
  model.currentCell = self;
  self.model = model;
}

- (void)textfieldDidChanged:(UITextField*)textField {
  
  NSDecimalNumber* newRes = [[NSDecimalNumber alloc] initWithString:textField.text];
  if ([newRes isEqualToNumber:[NSDecimalNumber notANumber]]) {
    newRes = [NSDecimalNumber zero];
  }
  self.model.amountForExchange = newRes;
}

@end
