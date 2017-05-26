//
//  HLCurrencyParser.m
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import "HLCurrencyParser.h"
#import "HLCurrency.h"

@interface HLCurrencyParserImpl () <NSXMLParserDelegate>
@property (nonatomic, strong) HLCurrency* origin;
@property (nonatomic, strong) NSXMLParser* xmlParser;
@property (nonatomic, assign) void(^completion)(id<HLCurrencyConverter> currency);
@end

@implementation HLCurrencyParserImpl

- (instancetype)initWithOriginCurrency:(HLCurrency*) currency {
  if (self = [super init]) {
    _origin = currency;
  }
  
  return self;
}

- (void)parseData:(NSData*) data withCompletion: (void(^)(id<HLCurrencyConverter> currency)) completion {
  
  if (_xmlParser != nil) {
    completion(nil);
  }

  if ((_xmlParser = [[NSXMLParser alloc] initWithData:data]) == nil) {
    completion(nil);
  }
  
  [_xmlParser setDelegate:self];
  self.completion = completion;
  [_xmlParser parse];
}

- (void)parser:(NSXMLParser *)parser
  didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
  qualifiedName:(NSString *)qName
  attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
  
  if (
      [elementName isEqualToString:@"Cube"] == YES
      && attributeDict[@"currency"] != nil
     ) {
    
    NSDecimalNumber* rate = [[NSDecimalNumber alloc] initWithString:attributeDict[@"rate"]];
    [_origin addCurrency:attributeDict[@"currency"] rate:rate];
  }
  
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
  self.completion(self.origin);
}

@end
