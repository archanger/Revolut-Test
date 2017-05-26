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

@interface HLCurrencyInteractor ()

@property (nonatomic, strong) HLCurrencyService* service;
@property (nonatomic, strong) HLCurrency* currentCurrency;

@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, assign) BOOL isUpdateing;

@property (nonatomic, strong) NSArray<HLAccount*>* accounts;

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
          [strongSelf.output dataUpdated];
          [strongSelf setIsUpdateing:NO];
        }
      });
  }];
}

- (void)exchange {
  
}

@end
