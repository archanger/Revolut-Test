//
//  HLCurrencyInteractor.m
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import "HLCurrencyInteractor.h"
#import "HLCurrencyService.h"
#import "HLCurrency.h"
#import "HLProvider.h"
#import "HLAccount.h"
#import "HLInfinitHorizontalCollectionView.h"
#import "HLCurrencyCell.h"
#import "UICollectionView+HLCellRegistrator.h"
#import "HLCollectionCompatible.h"
#import "HLCurrencyInputCell.h"


#define FROM_COLLECTION_VIEW 1
#define TO_COLLECTION_VIEW   2

@interface HLCurrencyInteractor () <HLInfinitHorizontalCollectionViewDataSource, HLCurrencyInputCellModelDelegate>

@property (nonatomic, strong) HLCurrencyService* service;

@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, assign) BOOL isUpdateing;

@property (nonatomic, strong) NSArray<HLAccount*>* accounts;
@property (nonatomic, strong) id<HLCurrencyConverter> currentCurrency;

@property (nonatomic, assign) NSInteger accountFromIndex;
@property (nonatomic, assign) NSInteger accountToIndex;

@property (nonatomic, strong) NSArray<HLCurrencyInputCellModel*>* fromModels;
@property (nonatomic, strong) NSArray<HLCurrencyCellModel*>* toModels;
@end

@implementation HLCurrencyInteractor

- (instancetype)init {
  if (self = [super init]) {
    id<HLProvider> provider = [[HLProviderImpl alloc] init];
    _service = [[HLCurrencyService alloc] initWith:provider];
    _isUpdateing = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:30.0
                                              target:self
                                            selector:@selector(updateData)
                                            userInfo:nil
                                             repeats:YES
    ];
    
    _accounts = @[
      [[HLAccount alloc] initWithCurrencyCode:@"USD" amount:[[NSDecimalNumber alloc] initWithInt:100]],
      [[HLAccount alloc] initWithCurrencyCode:@"EUR" amount:[[NSDecimalNumber alloc] initWithInt:100]],
      [[HLAccount alloc] initWithCurrencyCode:@"GBP" amount:[[NSDecimalNumber alloc] initWithInt:100]]
    ];
    
    [self generateModels];
    
  }
  
  return self;
}

- (void)updateData {

  if ([self isUpdateing] == YES) {
    return;
  }
  
  [self setIsUpdateing:YES];

  __weak typeof(self) weakSelf = self;

  [self.service requestCurrencyWithCompletion:^(id<HLCurrencyConverter> currency) {
    
      dispatch_async(dispatch_get_main_queue(), ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf != nil) {
          [strongSelf currencyUpdated:currency];
          [strongSelf setIsUpdateing:NO];
        }
      });
  }];
}

- (void)exchange {
  
  if (self.accountToIndex == self.accountFromIndex) {
    return;
  }
  
  HLAccount* fromAccount = self.accounts[self.accountFromIndex];
  HLAccount* toAccount = self.accounts[self.accountToIndex];
  
  HLCurrencyInputCellModel* data = self.fromModels[self.accountFromIndex];
  
  if ([fromAccount.amount compare:data.amountForExchange] == NSOrderedAscending) {
    [self.output notEnough];
    return;
  }
  
  
  NSDecimalNumber* rate = [self.currentCurrency calculateRateFrom:fromAccount.currencyCode toCurrency:toAccount.currencyCode];
  NSDecimalNumber* newAmount = [rate decimalNumberByMultiplyingBy:data.amountForExchange];
  
  fromAccount.amount = [fromAccount.amount decimalNumberBySubtracting:data.amountForExchange];
  toAccount.amount = [toAccount.amount decimalNumberByAdding:newAmount];
  
  data.totalAmount = fromAccount.amount;
  HLCurrencyCellModel* toModel = self.toModels[self.accountToIndex];
  toModel.totalAmount = toAccount.amount;
  
  [self generateModels];
  [self.output reload];
}

- (void)requestCellsNib {
  [self.output registerCells:@[[HLCurrencyCell class], [HLCurrencyInputCell class]]];
}


- (void)currencyUpdated:(id<HLCurrencyConverter>)currency {
  
  
  
  [self setCurrentCurrency:currency];
  [self updateRate];
}

- (void)updateRate {
  HLCurrencyExchangeRate* rate = [[HLCurrencyExchangeRate alloc] init];
  rate.fromCurrencyCode = self.accounts[self.accountFromIndex].currencyCode;
  rate.toCurrencyCode = self.accounts[self.accountToIndex].currencyCode;
  rate.rate = [self.currentCurrency calculateRateFrom:rate.fromCurrencyCode toCurrency:rate.toCurrencyCode];
  [self.output setExchangeRate:rate];
}

- (void)updateInputTarget {
  HLCurrencyInputCellModel* model = self.fromModels[self.accountFromIndex];
  [model setCurrentInput];
}

- (NSInteger)numberOfItemsInInifinitCollectionView:(HLInfinitHorizontalCollectionView *)view {
  return self.accounts.count;
}

- (UICollectionViewCell *)infinitCollectionView:(HLInfinitHorizontalCollectionView *)view
                         cellForDequedIndexPath:(NSIndexPath *)indexPath
                                    itemAtIndex:(NSInteger)index {
  
  id<HLCollectionCompatible> model;
  
  switch (view.tag) {
    case FROM_COLLECTION_VIEW:
      model = self.fromModels[index];
      break;
    
    case TO_COLLECTION_VIEW:
      model = self.toModels[index];
      break;
      
    default:
      break;
  }
  
  return [model cellForCollectionView:view atIndexPath:indexPath];
}

- (void)infinitCollectionView:(HLInfinitHorizontalCollectionView *)view didChangeCurrentPage:(NSInteger)index {
  
  [self updateInputTarget];
  
  switch (view.tag) {
    case FROM_COLLECTION_VIEW:
      self.accountFromIndex = index;
      break;
      
    case TO_COLLECTION_VIEW:
      self.accountToIndex = index;
      break;
      
    default:
      break;
  }
  
  
  [self updateRate];
  [self currencyInputModelChanged:nil];
}

- (void)currencyInputModelChanged:(HLCurrencyInputCellModel *)model {
  
  HLCurrencyInputCellModel* accountFrom = self.fromModels[self.accountFromIndex];
  HLCurrencyCellModel* accountTo = self.toModels[self.accountToIndex];
  NSDecimalNumber* rate = [self.currentCurrency calculateRateFrom:accountFrom.currency toCurrency:accountTo.currency];
  NSDecimalNumber* toExchange = [rate decimalNumberByMultiplyingBy:accountFrom.amountForExchange];
  accountTo.amountForExchange = toExchange;
}

- (void)generateModels {
  
  NSMutableArray* from = [[NSMutableArray alloc] initWithCapacity:_accounts.count];
  NSMutableArray* to = [[NSMutableArray alloc] initWithCapacity:_accounts.count];
  
  [_accounts enumerateObjectsUsingBlock:^(HLAccount * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    HLCurrencyInputCellModel* fromM = [[HLCurrencyInputCellModel alloc] init];
    fromM.currency = obj.currencyCode;
    fromM.totalAmount = obj.amount;
    fromM.delegate = self;
    
    HLCurrencyCellModel* toM = [[HLCurrencyCellModel alloc] init];
    toM.currency = obj.currencyCode;
    toM.totalAmount = obj.amount;
    
    [from addObject:fromM];
    [to addObject:toM];
  }];
  
  _fromModels = [from copy];
  _toModels = [to copy];
}

@end

@implementation HLCurrencyExchangeRate
@end
