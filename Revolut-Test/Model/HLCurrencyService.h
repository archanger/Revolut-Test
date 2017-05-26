//
//  CurrencyService.h
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLCurrency.h"

@protocol HLProvider;

@interface HLCurrencyService : NSObject

- (instancetype)initWith:(id<HLProvider>) provider;
- (void)requestCurrencyWithCompletion: (void(^)(id<HLCurrencyConverter> currency)) completion;

@end
