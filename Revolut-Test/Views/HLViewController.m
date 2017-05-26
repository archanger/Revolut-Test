//
//  ViewController.m
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import "HLViewController.h"
#import "HLCurrencyService.h"
#import "HLProvider.h"
#import "HLCurrencyInteractor.h"

@interface HLViewController () <HLCurrencyOutput>

@property (nonatomic, strong) id<HLViewSource> source;

@end

@implementation HLViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    [self _init];
  }
  
  return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    [self _init];
  }
  
  return self;
}

- (void)_init {
  HLCurrencyInteractor* interactor = [[HLCurrencyInteractor alloc] init];
  interactor.output = self;
  _source = interactor;
  
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [_source updateData];
}

- (void)dataUpdated {
  NSLog(@"did update");
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];

}


@end
