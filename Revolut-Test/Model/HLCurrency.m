//
//  Currency.m
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import "HLCurrency.h"

@class CurrencyLink;

@interface CurrencyNode : NSObject

@property (nonatomic, nonnull, copy) NSString* name;
@property (nonatomic, nullable) NSMutableDictionary<NSString*, CurrencyLink*>* links;

- (instancetype)initWithName:(NSString*) name;

@end

@implementation CurrencyNode

- (instancetype)initWithName:(NSString*) name {
  if (self = [super init]) {
    _name = name;
    _links = [[NSMutableDictionary alloc] init];
  }
  
  return self;
}

@end

@interface CurrencyLink : NSObject

@property (nonatomic, nonnull, strong) NSDecimalNumber* weight;
@property (nonatomic, weak, nullable) CurrencyNode* fromNode;
@property (nonatomic, strong, nonnull) CurrencyNode* toNode;

@end

@implementation CurrencyLink

@end

@interface HLCurrency ()

@property (nonatomic, nonnull, strong) CurrencyNode* originNode;
@property (nonatomic, assign) NSInteger originRate;

@end


@implementation HLCurrency

- (instancetype)initWithOrigin: (NSString*) origin {
  if (self = [super init]) {
    _originNode = [[CurrencyNode alloc] initWithName:origin];
    _originRate = 1;
  }
  
  return self;
}

- (void)addCurrency:(NSString*) currency rate:(NSDecimalNumber*) rate {
  
  CurrencyNode* node = [[CurrencyNode alloc] initWithName:currency];
  CurrencyLink* link = [[CurrencyLink alloc] init];
  link.weight = rate;
  link.toNode = node;
  
  _originNode.links[currency] = link;
  link.fromNode = _originNode;
}

- (NSDecimalNumber*)calculateRateFrom:(NSString*) fromCurrency toCurrency:(NSString*) toCurrency {
  
  if ([fromCurrency isEqualToString:toCurrency]) {
    return [[NSDecimalNumber alloc] initWithInt:1];
  }
  
  if ([fromCurrency isEqualToString:_originNode.name] == YES) {
    return _originNode.links[toCurrency].weight;
  }
  
  NSDecimalNumber* reverse = [[[NSDecimalNumber alloc] initWithInteger:[self originRate]]
                                decimalNumberByDividingBy: _originNode.links[fromCurrency].weight
                              ];
  
  if ([toCurrency isEqualToString:_originNode.name] == YES) {
    return reverse;
  }
  
  return [_originNode.links[toCurrency].weight decimalNumberByMultiplyingBy:reverse];
}

@end
