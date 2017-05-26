//
//  HLProvider.m
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import "HLProvider.h"
#import "HLCurrency.h"

@implementation HLProviderImpl

- (nonnull NSURLRequest*)request {
  NSURL* url = [[NSURL alloc] initWithString:@"http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"];
  NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
  
  return request;
}
- (nonnull id<HLCurrencyParser>)parser {
  
  HLCurrency* origin = [[HLCurrency alloc] initWithOrigin:@"EUR"];
  HLCurrencyParserImpl* parser = [[HLCurrencyParserImpl alloc] initWithOriginCurrency:origin];
  return parser;
}

@end
