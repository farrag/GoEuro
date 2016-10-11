//
//  Colors.m
//  GeEuro
//
//  Created by Ahmad Farrag on 10/10/16.
//  Copyright © 2016 Ahmad Farrag. All rights reserved.
//

#import "Colors.h"

@interface Colors ()

@property (nonatomic, strong) UIColor *mainColor;
@property (nonatomic, strong) UIColor *menuIndicatorColor;

@end

@implementation Colors

static Colors *sharedInstance = nil;

+ (instancetype)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Colors alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.mainColor = [UIColor colorWithRed:23/255.0 green:99/255.0 blue:161/255.0 alpha:1];
        self.menuIndicatorColor = [UIColor colorWithRed:250/255.0 green:155/255.0 blue:52/255.0 alpha:1.0];
    }
    return self;
}

@end
