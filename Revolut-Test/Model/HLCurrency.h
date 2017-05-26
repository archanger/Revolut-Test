//
//  Currency.h
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HLCurrencyConverter <NSObject>
- (nullable NSDecimalNumber*)calculateRateFrom:(nonnull NSString*) fromCurrency toCurrency:(nonnull NSString*) toCurrency;
@end

@interface HLCurrency : NSObject <HLCurrencyConverter>

- (nullable instancetype)initWithOrigin: (nonnull NSString*) origin;
- (void)addCurrency:(nonnull NSString*) currency rate:(nonnull NSDecimalNumber*) rate;
@end
