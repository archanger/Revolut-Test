//
//  HLAccount.m
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import "HLAccount.h"

@implementation HLAccount

- (instancetype)initWithCurrencyCode:(NSString*) code amount:(NSDecimalNumber*)amount {
  if (self = [super init]) {
    _currencyCode = code;
    _amount = amount;
  }
  
  return self;
}

@end
