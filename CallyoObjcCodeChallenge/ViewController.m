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

#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//{
    NSMutableArray *weatherData;
//}

    NSString *defaultCity = @"New York";

    NSString *baseURL = @"https://api.openweathermap.org/data/2.5/forecast?";

    NSString *queryParameter = @"q=";

    NSString *appIDParameter = @"&appid=";

    /// replace this with valid API key
    NSString *apiKey = @"fc490ca55b05ce6da7b75de78fc86cc6";

- (void)viewDidLoad {
    [super viewDidLoad];
    
     weatherData = [[NSMutableArray alloc]init];
    
    self.navigationItem.title = @"Find Your Local Weather";
    
//     @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini",
    
//    weatherData = [NSMutableArray arrayWithObjects:@"Egg Benedict", nil];
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
    } else {
        NSLog(@"Button Pushed & text not empty");
        
        encodedCityString = [self.searchTextField.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    }
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];

    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];

    if (networkStatus == NotReachable) {
        
        UIAlertView *alertController = [[UIAlertView alloc]
                                        initWithTitle:@"Alert" message:@"No network connection found.  Please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alertController show];
        
    } else {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

        [params setObject:@"INDIA" forKey:@"address"];
        [params setObject:@"para" forKey:@"key"];

        // if your api is right
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"application/json"];

        NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@", baseURL, queryParameter, encodedCityString, appIDParameter, apiKey];
        
//        NSLog(urlString);
        
        [manager POST:urlString parameters:params success:^(NSURLSessionTask *task, id responseObject) {
            
//            NSLog(@"JSON: %@", responseObject);
//            NSLog(@"result");
            
//            clouds =     {
//                all = 56;
//            };
//            dt = 1522389600;
//            "dt_txt" = "2018-03-30 06:00:00";
//            main =     {
//                "grnd_level" = "1026.28";
//                humidity = 92;
//                pressure = "1026.28";
//                "sea_level" = "1029.65";
//                temp = "280.269";
//                "temp_kf" = 0;
//                "temp_max" = "280.269";
//                "temp_min" = "280.269";
//            };
//            rain =     {
//            };
//            sys =     {
//                pod = n;
//            };
//            weather =     (
//                           {
//                               description = "broken clouds";
//                               icon = 04n;
//                               id = 803;
//                               main = Clouds;
//                           }
//                           );
//            wind =     {
//                deg = "279.509";
//                speed = "0.91";
//            };
//        }
         
            for (NSDictionary* currentDictionary in responseObject[@"list"]) {

                [weatherData addObject: currentDictionary];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{ [self.weatherTableView reloadData]; });
            
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
    
    NSDictionary *forecast = [weatherData objectAtIndex:indexPath.row];
    
        NSNumber *time = forecast[@"dt"];
    
    NSDictionary *main = forecast[@"main"];
    
        NSNumber *humidity = main[@"humidity"];
    
        NSNumber *min = main[@"temp_min"];

        NSNumber *max = main[@"temp_max"];

    NSArray *weather = forecast[@"weather"];

    NSDictionary *weatherDetail = weather[0];
    
        NSString *longDescription = weatherDetail[@"description"];

        NSString *icon = weatherDetail[@"icon"];
    
        NSString *shortDescription = weatherDetail[@"main"];
    
    NSLog(@"humidity: %@", humidity);
    NSLog(@"min: %@", min);
    NSLog(@"max: %@", max);
    NSLog(@"longDescription: %@", longDescription);
    NSLog(@"shortDescription: %@", shortDescription);
    NSLog(@"icon: %@", icon);
    NSLog(@"time: %@", time);
    
        cell.textLabel.text = [time stringValue];
    
    if ([icon  isEqual: @"01d"]) {
        cell.imageView.image = [UIImage imageNamed:@"01d.png"];
    } else if ([icon  isEqual: @"02d"]) {
        cell.imageView.image = [UIImage imageNamed:@"02d.png"];
    } else if ([icon  isEqual: @"03d"]) {
        cell.imageView.image = [UIImage imageNamed:@"03d.png"];
    } else if ([icon  isEqual: @"04d"]) {
        cell.imageView.image = [UIImage imageNamed:@"04d.png"];
    } else if ([icon  isEqual: @"09d"]) {
        cell.imageView.image = [UIImage imageNamed:@"09d.png"];
    } else if ([icon  isEqual: @"10d"]) {
        cell.imageView.image = [UIImage imageNamed:@"10d.png"];
    } else if ([icon  isEqual: @"11d"]) {
        cell.imageView.image = [UIImage imageNamed:@"11d.png"];
    } else if ([icon  isEqual: @"13d"]) {
        cell.imageView.image = [UIImage imageNamed:@"13d.png"];
    } else if ([icon  isEqual: @"50d"]) {
        cell.imageView.image = [UIImage imageNamed:@"50d.png"];
    } else if ([icon  isEqual: @"01n"]) {
        cell.imageView.image = [UIImage imageNamed:@"01n.png"];
    } else if ([icon  isEqual: @"02n"]) {
        cell.imageView.image = [UIImage imageNamed:@"02n.png"];
    } else if ([icon  isEqual: @"03n"]) {
        cell.imageView.image = [UIImage imageNamed:@"03n.png"];
    } else if ([icon  isEqual: @"04n"]) {
        cell.imageView.image = [UIImage imageNamed:@"04n.png"];
    } else if ([icon  isEqual: @"09n"]) {
        cell.imageView.image = [UIImage imageNamed:@"09n.png"];
    } else if ([icon  isEqual: @"10n"]) {
        cell.imageView.image = [UIImage imageNamed:@"10n.png"];
    } else if ([icon  isEqual: @"11n"]) {
        cell.imageView.image = [UIImage imageNamed:@"11n.png"];
    } else if ([icon  isEqual: @"13n"]) {
        cell.imageView.image = [UIImage imageNamed:@"13n.png"];
    } else if ([icon  isEqual: @"50n"]) {
        cell.imageView.image = [UIImage imageNamed:@"50n.png"];
    } else {
        cell.imageView.image = nil;
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"weatherDetailSegue"])
    {
        // Get reference to the destination view controller
        DetailViewController *dest = [segue destinationViewController];
        
        NSIndexPath *indexPath = [_weatherTableView indexPathForSelectedRow];
        
        dest.view.backgroundColor = UIColor.greenColor;
        
        NSLog(@"%@", indexPath);
        
        dest.tempHighLabel.text     = [weatherData objectAtIndex:indexPath.row];
        dest.tempLowLabel.text      = [weatherData objectAtIndex:indexPath.row];
        dest.humidityLabel.text     = [weatherData objectAtIndex:indexPath.row];
        dest.windLabel.text         = [weatherData objectAtIndex:indexPath.row];
        dest.descriptionLabel.text  = [weatherData objectAtIndex:indexPath.row];
        dest.iconView.image         = [UIImage imageNamed:@"cloudy.png"];
        
    }
}

@end
