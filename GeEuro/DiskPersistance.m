//
//  DiskPersistance.m
//  GoEuto
//
//  Created by Ahmad Farrag on 10/11/16.
//  Copyright © 2016 Ahmad Farrag. All rights reserved.
//

#import "DiskPersistance.h"

@implementation DiskPersistance

static DiskPersistance *diskPersistance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        diskPersistance = [[DiskPersistance alloc] init];
    });
    
    return diskPersistance;
}

- (NSString *)getCacheDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return [self createDirectoryAtPathIfNotExist:[basePath stringByAppendingString:@"/GoEuroCache/"]];
}

- (void)cacheResponse:(NSDictionary *)responde withName:(NSString *)name {
    NSString *cacheDirectory = [self getCacheDirectory];
    [responde writeToFile:[cacheDirectory stringByAppendingString:name] atomically:NO];
}

- (void)cacheImage:(UIImage *)image withName:(NSString *)name {
    NSString *cacheDirectory = [self getCacheDirectory];
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:[cacheDirectory stringByAppendingString:name] atomically:NO];
}

- (NSString *)createDirectoryAtPathIfNotExist:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return path;
}

- (NSData *)loadDataWithName:(NSString *)name {
    NSString *path = [NSString stringWithFormat:@"%@%@", [self getCacheDirectory], name];
    return [NSData dataWithContentsOfFile:path];
}

@end
