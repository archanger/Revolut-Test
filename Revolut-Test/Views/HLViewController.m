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
#import "HLInfinitHorizontalCollectionView.h"
#import "HLReusableCell.h"
#import "UICollectionView+HLCellRegistrator.h"

@interface HLViewController () <HLCurrencyOutput>

@property (nonatomic, strong) id<HLViewSource> source;

@property (weak, nonatomic) IBOutlet HLInfinitHorizontalCollectionView *fromCollectionView;
@property (weak, nonatomic) IBOutlet HLInfinitHorizontalCollectionView *toCollectionView;

@property (weak, nonatomic) IBOutlet UILabel *exchangeRateLabel;
@property (weak, nonatomic) IBOutlet UIButton *exchangeButton;

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
  
  self.fromCollectionView.infinitDataSource = self.source;
  self.toCollectionView.infinitDataSource = self.source;
  
  [self.source requestCellsNib];
  [self.source updateData];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  
  [self.fromCollectionView scrollToFirstItem];
  [self.toCollectionView scrollToFirstItem];
}

- (void)reload {
  [self.fromCollectionView reloadData];
  [self.toCollectionView reloadData];
}

- (void)registerCells:(NSArray<Class<HLReusableCell>> *)cells {
  
  [cells enumerateObjectsUsingBlock:^(Class<HLReusableCell>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    [self.fromCollectionView registerCell:obj];
    [self.toCollectionView registerCell:obj];
  }];
}

- (void)setExchangeRate:(HLCurrencyExchangeRate *)rate {
  
  NSNumberFormatter* fromFormatter = [[NSNumberFormatter alloc] init];
  fromFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
  fromFormatter.currencyCode = rate.fromCurrencyCode;
  fromFormatter.minimumFractionDigits = 0;
  
  NSNumberFormatter* toFormatter = [[NSNumberFormatter alloc] init];
  toFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
  toFormatter.currencyCode = rate.toCurrencyCode;
  toFormatter.minimumFractionDigits = 5;
  
  self.exchangeRateLabel.text = [
     NSString stringWithFormat:@"%@ = %@",
      [fromFormatter stringFromNumber:@1],
      [toFormatter stringFromNumber:rate.rate]
  ];
}

- (void)notEnough {
  
  UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Not Enough"
                                                                 message:@"You do not have enough sum"
                                                          preferredStyle:UIAlertControllerStyleAlert];
  
  UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
  [alert addAction:cancelAction];
  
  [self presentViewController:alert animated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];

}

- (IBAction)exchangeTapped {
  [self.source exchange];
}

@end
