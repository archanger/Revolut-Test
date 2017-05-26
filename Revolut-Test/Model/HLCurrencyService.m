//
//  CurrencyService.m
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import "HLCurrencyService.h"
#import "HLCurrencyParser.h"
#import "HLProvider.h"

@interface HLCurrencyService ()

@property (nonatomic, strong) NSURLSession* session;
@property (nonatomic, strong) id<HLProvider> provider;

@end

@implementation HLCurrencyService

- (instancetype)initWith:(id<HLProvider>) provider {
  if (self = [super init]) {
    _session = [NSURLSession sharedSession];
    _provider = provider;
  }
  
  return self;
}

- (void)requestCurrencyWithCompletion: (void(^)(id<HLCurrencyConverter> currency)) completion {

  __weak typeof(self) weakSelf = self;

  [[_session dataTaskWithRequest:[[self provider] request]
    completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      
      id<HLCurrencyParser> parser = [[weakSelf provider] parser];
      [parser parseData:data withCompletion:completion];
      
    }
  ] resume];
  
}

- (void)dealloc {
  [_session invalidateAndCancel];
}

@end
