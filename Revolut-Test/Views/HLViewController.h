//
//  ViewController.h
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HLInfinitHorizontalCollectionView.h"

@protocol HLViewSource <NSObject, HLInfinitHorizontalCollectionViewDataSource>

- (void)updateData;
- (void)exchange;
- (void)requestCellsNib;

@end

@interface HLViewController : UIViewController


@end

