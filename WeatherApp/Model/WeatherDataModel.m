//
//  WeatherDataModel.m
//  WeatherApp
//
//  Created by 01HWCL847730 on 1/17/19.
//  Copyright © 2019 devratna. All rights reserved.
//

#import "WeatherDataModel.h"

@implementation WeatherDataModel


- (id)initWithWeatherData:(NSDictionary *)weatherData {
    if (self = [super init]) {
    [self setPropertiesWithDictionary:weatherData];
    }
    return self;
}

- (void)setPropertiesWithDictionary:(NSDictionary *)weatherData {

    NSNumber *tempResult = [NSNumber numberWithInt:[[weatherData valueForKeyPath:@"main.temp"] doubleValue] - 273.15];
   // NSInteger tempVal = [tempResult intValue];
    self.temp = tempResult;
    self.city = [weatherData valueForKey:@"name"];
    NSArray *weatheraArray = [weatherData valueForKey:@"weather"];
    NSDictionary *dict = weatheraArray[0];
    int conditionVal = [[dict valueForKeyPath:@"id"]intValue];
    [self updateWeatherIcon:conditionVal];
}

- (void) updateWeatherIcon:(int)idVal {
    
    switch (idVal) {
        case 0 ... 300 :
            self.weatherIconName = @"tstorm1";
            break;
        case 301 ... 500 :
            self.weatherIconName = @"light_rain";
            break;
        case 501 ... 600 :
            self.weatherIconName = @"shower3";
            break;
        case 601 ... 700 :
            self.weatherIconName = @"snow4";
            break;
        case 701 ... 771 :
            self.weatherIconName = @"fog";
            break;
        case 772 ... 799 :
            self.weatherIconName = @"tstorm3";
            break;
        case 800 :
            self.weatherIconName = @"sunny";
            break;
        case 801 ... 804 :
            self.weatherIconName = @"cloudy2";
            break;
        case 900 ... 902 :
            self.weatherIconName = @"tstorm3";
            break;
        case 905 ... 1000 :
            self.weatherIconName = @"tstorm3";
            break;
        case 903 :
             self.weatherIconName = @"snow5";
             break;
        case 904 :
            self.weatherIconName = @"sunny";
            break;
        default:
            self.weatherIconName = @"dunno";
            break;
    }
 }

@end
