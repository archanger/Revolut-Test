//
//  HLCurrencyParser.h
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HLCurrencyConverter;
@class HLCurrency;

@protocol HLCurrencyParser <NSObject>
- (void)parseData:(NSData*) data withCompletion: (void(^)(id<HLCurrencyConverter> currency)) completion;
@end

@interface HLCurrencyParserImpl : NSObject <HLCurrencyParser>

- (instancetype)initWithOriginCurrency:(HLCurrency*) currency;

@end
