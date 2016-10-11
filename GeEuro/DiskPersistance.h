//
//  DiskPersistance.h
//  GoEuto
//
//  Created by Ahmad Farrag on 10/11/16.
//  Copyright © 2016 Ahmad Farrag. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DiskPersistance : NSObject

+ (instancetype)sharedInstance;
- (void)cacheResponse:(NSDictionary *)responde withName:(const NSString *)name;
- (void)cacheImage:(UIImage *)image withName:(NSString *)name;

- (NSData *)loadDataWithName:(const NSString *)name;

@end
