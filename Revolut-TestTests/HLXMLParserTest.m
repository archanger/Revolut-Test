//
//  HLXMLParserTest.m
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HLCurrencyParser.h"
#import "HLCurrency.h"

@interface HLXMLParserTest : XCTestCase
@property (nonatomic, strong) HLCurrencyParserImpl* parser;
@end

@implementation HLXMLParserTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
  
    HLCurrency* currency = [[HLCurrency alloc] initWithOrigin:@"EUR"];
    _parser = [[HLCurrencyParserImpl alloc] initWithOriginCurrency:currency];
  
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testParsing {
  
  NSString* testStr = @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>"
                      @"<gesmes:Envelope xmlns:gesmes=\"http://www.gesmes.org/xml/2002-08-01\" xmlns=\"http://www.ecb.int/vocabulary/2002-08-01/eurofxref\">"
                      @"<gesmes:subject>Reference rates</gesmes:subject>"
                      @"<gesmes:Sender>"
                        @"<gesmes:name>European Central Bank</gesmes:name>"
                      @"</gesmes:Sender>"
                      @"<Cube>"
                        @"<Cube time='2017-05-25'>"
                      @"<Cube currency='USD' rate='1.1214'/>"
                      @"<Cube currency='JPY' rate='125.33'/>"
                      @"<Cube currency='BGN' rate='1.9558'/>"
                      @"<Cube currency='CZK' rate='26.413'/>"
                      @"<Cube currency='DKK' rate='7.4409'/>"
                      @"<Cube currency='GBP' rate='0.86528'/>"
                        @"</Cube>"
                      @"</Cube>"
                      @"</gesmes:Envelope>";
  
  [_parser parseData:[testStr dataUsingEncoding:NSUTF8StringEncoding] withCompletion:^(id<HLCurrencyConverter> currency) {
  
    XCTAssert([currency calculateRateFrom:@"USD" toCurrency:@"GBP"] != nil);
    
  }];
  
  
}


@end
