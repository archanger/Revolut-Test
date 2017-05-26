//
//  HLCurrencyTest.m
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HLCurrency.h"

@interface HLCurrencyTest : XCTestCase

@property (nonatomic) HLCurrency* c;

@end

@implementation HLCurrencyTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _c = [[HLCurrency alloc] initWithOrigin:@"EUR"];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddingNewCurrencies {


  [_c addCurrency:@"USD" rate:[[NSDecimalNumber alloc] initWithString:@"1.1214"]];
  [_c addCurrency:@"GBP" rate:[[NSDecimalNumber alloc] initWithString:@"0.86528"]];
  
  
  NSDecimalNumber* usd_to_eur = [_c calculateRateFrom:@"USD" toCurrency:@"EUR"];
  NSDecimalNumber* gbp_to_eur = [_c calculateRateFrom:@"GBP" toCurrency:@"EUR"];
  NSDecimalNumber* gbp_to_usd = [_c calculateRateFrom:@"GBP" toCurrency:@"USD"];

  XCTAssert([usd_to_eur isEqualToNumber:[[NSDecimalNumber alloc] initWithString:@"0.8917424647761726413411806670233636"]] == YES);
  XCTAssert([gbp_to_eur isEqualToNumber:[[NSDecimalNumber alloc] initWithString:@"1.155695266272189349112426035502958"]] == YES);
  XCTAssert([gbp_to_usd isEqualToNumber:[[NSDecimalNumber alloc] initWithString:@"1.2959966715976331360946745562130171012"]] == YES);
  
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


@end
