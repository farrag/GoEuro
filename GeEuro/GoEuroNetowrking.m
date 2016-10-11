//
//  GoEuroNetowrking.m
//  GeEuro
//
//  Created by Ahmad Farrag on 10/11/16.
//  Copyright © 2016 Ahmad Farrag. All rights reserved.
//

#import "GoEuroNetowrking.h"

static const NSString *kBaseURL = @"https://api.myjson.com/bins/";

@implementation GoEuroNetowrking

static GoEuroNetowrking *goEuroNetowrking = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        goEuroNetowrking = [[GoEuroNetowrking alloc] init];
    });
    
    return goEuroNetowrking;
}

- (void)getJSONResponseForEndpoint:(const NSString *)endpoint withCompletionHandler:(void (^)(id, NSError *))completion {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.URLCache = [NSURLCache sharedURLCache];
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    self.session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", kBaseURL, endpoint];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    self.dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        completion(data, error);
        dispatch_semaphore_signal(sema);
    }];
    [self.dataTask resume];
}

- (void)getImageFromPath:(NSString *)path withCompletionHandler:(void (^)(id, NSError *))completion {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.URLCache = [NSURLCache sharedURLCache];
    configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    self.session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    self.dataTask = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        completion(data, error);
        dispatch_semaphore_signal(sema);
    }];
    [self.dataTask resume];
}

@end
