//
//  Colors.h
//  GeEuro
//
//  Created by Ahmad Farrag on 10/10/16.
//  Copyright © 2016 Ahmad Farrag. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Colors : NSObject

@property (nonatomic, strong, readonly) UIColor *mainColor;
@property (nonatomic, strong, readonly) UIColor *menuIndicatorColor;

+ (instancetype)getInstance;

@end
