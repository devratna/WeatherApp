//
//  WeatherNetworkManager.h
//  WeatherApp
//
//  Created by 01HWCL847730 on 1/16/19.
//  Copyright © 2019 devratna. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#define kMintBaseURL                    @"http://api.openweathermap.org"
#define kAppId                          @"e72ca729af228beabd5d20e3b7749713"
#define kFetchWeather                   @"/data/2.5/weather"

@interface WeatherNetworkManager : AFHTTPSessionManager
+ (instancetype)sharedManager;

- (NSURLSessionDataTask*)GETweatherFromLongitude:(NSString*)longitude
                                        latitude:(NSString*)latitude
                                         success:(void (^)(NSURLSessionDataTask *task, NSDictionary *responseDict))successBlock
                                         failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failureBlock;


@end
