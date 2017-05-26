//
//  HLProvider.h
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLCurrencyParser.h"

@protocol HLProvider <NSObject>

- (nonnull NSURLRequest*)request;
- (nonnull id<HLCurrencyParser>)parser;

@end

@interface HLProviderImpl : NSObject <HLProvider>

@end
