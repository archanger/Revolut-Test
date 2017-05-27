//
//  HLCollectionCompatible.h
//  Revolut-Test
//
//  Created by Кирилл Чуянов on 27.05.17.
//  Copyright © 2017 Home LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLCollectionCompatible <NSObject>
- (UICollectionViewCell*)cellForCollectionView:(UICollectionView*)view atIndexPath:(NSIndexPath*)indexPath;
@end
