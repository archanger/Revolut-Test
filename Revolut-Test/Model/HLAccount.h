//
//  HLAccount.h
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLAccount : NSObject

@property (nonatomic, copy) NSString* currencyCode;
@property (nonatomic, copy) NSDecimalNumber* amount;

- (instancetype)initWithCurrencyCode:(NSString*) code amount:(NSDecimalNumber*)amount;

@end
