//
//  HLReusableCell.h
//  Revolut-Test
//
//  Created by Кирилл Чуянов on 27.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

@import UIKit;

@protocol HLReusableCell <NSObject>

+ (NSString*)reuseIdentifier;
+ (UINib*)nib;

@end

@protocol HLReusableCellRegistrator <NSObject>

- (void)registerCell:(Class<HLReusableCell>)cell;

@end
