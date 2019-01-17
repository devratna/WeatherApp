//
//  WeatherViewController.m
//  WeatherApp
//
//  Created by 01HWCL847730 on 1/16/19.
//  Copyright © 2019 devratna. All rights reserved.
//

#import "WeatherViewController.h"
#import "WeatherNetworkManager.h"
#import "WeatherDataModel.h"

@interface WeatherViewController ()

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Adding default value of Mumbai
    [self userEnteredData:@"19.0100" andlat:@"72.8499"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 This method validates string

 @param string value
 @return boolean value
 */
- (BOOL) isValid:(NSString *)string {
    if (string == nil || [string isEqual:[NSNull null]] || ![string isKindOfClass:[NSString class]] ||[string isEqualToString:@""]) {
        return NO;
    }
    return YES;
}

/**
 This method will be called when user press the getWeather button

 @param sender id
 */
- (IBAction)getWeatherPressed:(id)sender {
    
    [self.longitude resignFirstResponder];
    [self.latitude resignFirstResponder];
    if(![self isValid:self.longitude.text]) {
        [self showAlertMessage:@"Please enter valid longitude value " withTitle:@"Error!"];
    }
   if(![self isValid:self.latitude.text]) {
        [self showAlertMessage:@"Please enter valid latitude value " withTitle:@"Error!"];
    }
    NSString *longitude = self.longitude.text;
    NSString *latitude = self.latitude.text;
    self.longitude.text = @"";
    self.latitude.text = @"";
    [self userEnteredData:longitude andlat:latitude];
}

/**
 This method will be called to call server API and handling
 response from server has been done in this method.

 @param longitude longitude text value
 @param latitude latitude text value
 */
- (void)userEnteredData:(NSString *)longitude andlat:(NSString *)latitude {
    
    [[WeatherNetworkManager sharedManager] GETweatherFromLongitude:longitude
                                                          latitude:latitude
                                                           success:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
    NSDictionary *jsonDict = [[NSDictionary alloc]initWithDictionary:responseDict];
    NSLog(@"JSON %@",jsonDict);
    NSLog(@"Success! Got the weather data");
    WeatherDataModel *model = [[WeatherDataModel alloc] initWithWeatherData:jsonDict];
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        NSString *final = [model.temp stringValue];
                                                        self.tempLabel.text = [final stringByAppendingString:@"°"];
                                                        self.cityLabel.text = model.city;
                                                        self.weatherImage.image = [UIImage imageNamed:model.weatherIconName];
                                                               });
    NSString *message = @"Success! Got the weather data of ";
    [self showAlertMessage:[message stringByAppendingString:model.city] withTitle:@"Success!"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self showAlertMessage:@"Error encountered please try again" withTitle:@"Error!"];
                                                           }];
}

/**
 This method will show alert based on the message it received

 @param message message
 @param title title
 */
- (void)showAlertMessage:(NSString*)message withTitle:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                          }];
    [alert addAction:defaultAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}



@end
