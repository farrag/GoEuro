//
//  UILabel+LabelHeight.h
//  Bogo
//
//  Created by Ahmed Farrag on 7/2/14.
//  Copyright (c) 2014 StarWallet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LabelHeight)

+ (CGFloat)calculateLabelHeightOfString:(NSString *)string andFont:(UIFont *)paramFont withWidth:(CGFloat)paramWidth;

@end
