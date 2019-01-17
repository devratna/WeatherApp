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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)getWeatherPressed:(id)sender {
    
    [self.longitude resignFirstResponder];
    [self.latitude resignFirstResponder];
    NSString *longitude = self.longitude.text;
    NSString *latitude = self.latitude.text;
    self.longitude.text = @"";
    self.latitude.text = @"";
    [self userEnteredData:longitude andlat:latitude];
}
- (void)userEnteredData:(NSString *)longitude andlat:(NSString *)latitude {
    
    [[WeatherNetworkManager sharedManager] GETweatherFromLongitude:longitude
                                                          latitude:latitude
                                                           success:^(NSURLSessionDataTask *task, NSDictionary *responseDict) {
    NSDictionary *jsonDict = [[NSDictionary alloc]initWithDictionary:responseDict];
    NSLog(@"JSON %@",jsonDict);
    NSLog(@"Success! Got the weather data");
    [self showAlertMessage:@"Success! Got the weather data" withTitle:@"Success!"];
    WeatherDataModel *model = [[WeatherDataModel alloc] initWithWeatherData:jsonDict];
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        NSString *final = [model.temp stringValue];
                                                        self.tempLabel.text = [final stringByAppendingString:@"°"];
                                                        self.cityLabel.text = model.city;
                                                        self.weatherImage.image = [UIImage imageNamed:model.weatherIconName] ;
                                                               });
                                                               
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
       // NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
         [self showAlertMessage:@"Error encountered please try again" withTitle:@"Error!"];

                                                           }];
}
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
