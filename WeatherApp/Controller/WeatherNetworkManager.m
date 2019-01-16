//
//  WeatherNetworkManager.m
//  WeatherApp
//
//  Created by 01HWCL847730 on 1/16/19.
//  Copyright © 2019 devratna. All rights reserved.
//

#import "WeatherNetworkManager.h"

@implementation WeatherNetworkManager

/**
 * This method returns a singleton object through which base URL, authorization, Version, Content
 * type can be shared across the application
 
 * @return shared object
 */
+ (instancetype)sharedManager {
    static WeatherNetworkManager* _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:kMintBaseURL]
                                  sessionConfiguration:config];
    });
    
    return _sharedManager;
}

/**
 * This method initialises base url and set HTTP header fields
 
 * @param url Base URL
 * @param configuration NSURL Session Configuration
 * @return self
 */
- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration {
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (self) {
        [self setRequestSerializer:[AFJSONRequestSerializer serializer]];
        [self setResponseSerializer:[AFJSONResponseSerializer
                                     serializerWithReadingOptions:NSJSONReadingAllowFragments]];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    return self;
}

- (NSURLSessionDataTask*)GETweatherFromLongitude:(NSString*)longitude
                                        latitude:(NSString*)latitude
                                         success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseDict))successBlock
                                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failureBlock {
    NSDictionary* parameters = @{@"lat":longitude, @"lon":latitude, @"appid" :kAppId };
    NSURLSessionDataTask* fetchWeatherTask = [self GET:kFetchWeather
                                            parameters:parameters
                                               success:successBlock
                                               failure:failureBlock];
    return fetchWeatherTask;
}

@end
