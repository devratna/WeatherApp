//
//  WeatherDataModel.h
//  WeatherApp
//
//  Created by 01HWCL847730 on 1/17/19.
//  Copyright © 2019 devratna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherDataModel : NSObject

@property (nonatomic, retain) NSNumber * temp;
@property (nonatomic, retain) NSString * condition;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * weatherIconName;

- (id)initWithWeatherData:(NSDictionary *)weatherData;

@end
