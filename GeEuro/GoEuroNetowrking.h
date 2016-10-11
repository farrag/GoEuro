//
//  GoEuroNetowrking.h
//  GeEuro
//
//  Created by Ahmad Farrag on 10/11/16.
//  Copyright © 2016 Ahmad Farrag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoEuroNetowrking : NSObject

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

+ (instancetype)sharedInstance;
- (void)getJSONResponseForEndpoint:(const NSString *)endpoint
             withCompletionHandler:(void(^)(id response, NSError *error))completion;
- (void)getImageFromPath:(NSString *)path withCompletionHandler:(void(^)(id response, NSError *error))completion;
@end
