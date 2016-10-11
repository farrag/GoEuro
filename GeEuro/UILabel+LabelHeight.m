//
//  UILabel+LabelHeight.m
//  Bogo
//
//  Created by Ahmed Farrag on 7/2/14.
//  Copyright (c) 2014 StarWallet. All rights reserved.
//

#import "UILabel+LabelHeight.h"

@implementation UILabel (LabelHeight)

+(CGFloat) calculateLabelHeightOfString:(NSString *)string andFont:(UIFont *)paramFont withWidth:(CGFloat)paramWidth
{
    return [string boundingRectWithSize:CGSizeMake(paramWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:paramFont, NSFontAttributeName, nil] context:nil].size.height;
}

@end
