//
//  ViewController.m
//  CallyoObjcCodeChallenge
//
//  Created by Anthony on 3/24/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

#import "ViewController.h"

#import <AFNetworking.h>

#import "Reachability.h"

@interface ViewController ()

@end

@implementation ViewController

{
    NSMutableArray *weatherData;
}

    NSString *defaultCity = @"New York";

    NSString *baseURL = @"https://api.openweathermap.org/data/2.5/forecast?";

    NSString *queryParameter = @"q=";

    NSString *appIDParameter = @"&appid=";

    /// replace this with valid API key
    NSString *apiKey = @"fc490ca55b05ce6da7b75de78fc86cc6";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Find Your Local Weather";
    
    weatherData = [NSMutableArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
    // Do any additional setup after loading the view, typically from a nib.
    
    _weatherTableView.delegate = self;
    
    _weatherTableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [weatherData count];
}

- (IBAction)searchButtonPushed:(UIButton *)sender {
    
    NSString *encodedCityString;

    if ([self.searchTextField.text  isEqual: @""]) {
        NSLog(@"text empty");
        
        encodedCityString = [defaultCity stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
//        NSLog(@"escapedString: %@", encodedCityString);
        
//        encodedCityString = [defaultCity stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    } else {
        NSLog(@"Button Pushed & text not empty");
        
        encodedCityString = [self.searchTextField.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
//        NSLog(@"escapedString: %@", encodedCityString);
        
//        encodedCityString = [self.searchTextField.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    }
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];

    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];

    if (networkStatus == NotReachable) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert!" message:@"No network connection found.  Please check your internet connection" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
        [alertController addAction:okAction];

        [self.presentViewController:alertController animated:YES completion:nil];
    } else {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

        [params setObject:@"INDIA" forKey:@"address"];
        [params setObject:@"para" forKey:@"key"];

        // if your api is right
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"application/json"];

        NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@", baseURL, queryParameter, encodedCityString, appIDParameter, apiKey];
        
        NSLog(urlString);
        
        [manager POST:urlString parameters:params success:^(NSURLSessionTask *task, id responseObject) {
            //        [manager POST:api parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            NSLog(@"JSON: %@", responseObject);
            NSLog(@"result");
        }
              failure:^(NSURLSessionTask *operation, NSError *error)
         { NSLog(@"ERROR: %@", error); }];
    }

    self.navigationItem.title = self.searchTextField.text;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [weatherData objectAtIndex:indexPath.row];
    
//        NSString *blah = [weatherData objectAtIndex:indexPath.row];
    
    return cell;
}


@end
