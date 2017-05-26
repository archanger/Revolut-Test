//
//  HLCurrencyInteractor.h
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLViewController.h"

@protocol HLCurrencyOutput <NSObject>
- (void)dataUpdated;
@end

@interface HLCurrencyInteractor : NSObject <HLViewSource>
@property (nonatomic, weak) id<HLCurrencyOutput> output;
@end
