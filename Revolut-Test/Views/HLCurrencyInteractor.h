//
//  HLCurrencyInteractor.h
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLViewController.h"
#import "HLReusableCell.h"

@interface HLCurrencyExchangeRate : NSObject
@property (nonatomic, copy) NSString* fromCurrencyCode;
@property (nonatomic, copy) NSString* toCurrencyCode;
@property (nonatomic, copy) NSDecimalNumber* rate;
@end

@protocol HLCurrencyOutput <NSObject>
- (void)reload;
- (void)registerCells:(NSArray<Class<HLReusableCell>>*)cells;
- (void)setExchangeRate:(HLCurrencyExchangeRate*)rate;
- (void)notEnough;
@end

@interface HLCurrencyInteractor : NSObject <HLViewSource>
@property (nonatomic, weak) id<HLCurrencyOutput> output;
@end
