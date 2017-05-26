//
//  ViewController.h
//  Revolut-Test
//
//  Created by Kirill on 26.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLViewSource <NSObject>

- (void)updateData;
- (void)exchange;

@end

@interface HLViewController : UIViewController


@end

