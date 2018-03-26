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

#import "WeatherTableViewCell.h"

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
        
        self.navigationItem.title = defaultCity;
        
        encodedCityString = [defaultCity stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    } else {
        NSLog(@"Button Pushed & text not empty");
        
        self.navigationItem.title = self.searchTextField.text;
        
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

        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject: @"application/json"];

        NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@", baseURL, queryParameter, encodedCityString, appIDParameter, apiKey];
        
        [manager POST:urlString parameters:params success:^(NSURLSessionTask *task, id responseObject) {
            
            [weatherData removeAllObjects];
            
            for (NSDictionary* currentDictionary in responseObject[@"list"]) {

                [weatherData addObject: currentDictionary];
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{ [self.weatherTableView reloadData]; });
            
        }
              failure:^(NSURLSessionTask *operation, NSError *error)
         { NSLog(@"ERROR: %@", error); }];
    }

    
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    WeatherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[WeatherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
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
    
//    NSLog(@"humidity: %@", humidity);
//    NSLog(@"min: %@", min);
//    NSLog(@"max: %@", max);
//    NSLog(@"longDescription: %@", longDescription);
//    NSLog(@"shortDescription: %@", shortDescription);
//    NSLog(@"icon: %@", icon);
//    NSLog(@"time: %@", time);
    
    cell.textLabel.text = [self convertDTtoShortTime:time];
//    cell.timeLabel.text = [self convertDTtoTime:time];
    cell.tempHighLabel.text = [self convertFromKelvinToF: max];
    cell.tempLowLabel.text = [self convertFromKelvinToF: min];
    cell.humidityLabel.text = [humidity stringValue];
    cell.descriptionLabel.text = shortDescription;
    cell.imageView.image = [self returnIcon:icon];
    
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
        
        dest.view.backgroundColor = UIColor.whiteColor;
        
//        NSLog(@"%@", indexPath);
        
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
        
        dest.tempHighLabel.text     = [self convertFromKelvinToF: max];
        dest.tempLowLabel.text      = [self convertFromKelvinToF: min];
        dest.humidityLabel.text     = [humidity stringValue];
        dest.descriptionLabel.text  = longDescription;
        dest.timeLabel.text         = [self convertDTtoLongTime:time];
        dest.iconView.image         = [self returnIcon:icon];
        
//        NSLog(@"longDescription: %@", [self convertDTtoTime:time]);
        
    }
}

- (NSString *)convertDTtoLongTime:(NSNumber *)timeNumber {
    
    double dtVal = [timeNumber doubleValue];
    /// convert from number to date
    NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:dtVal];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:epochNSDate
                                                          dateStyle:NSDateFormatterShortStyle 
                                                          timeStyle:NSDateFormatterFullStyle];
    NSLog(@"dateString: %@", dateString);
    return dateString;
}

- (NSString *)convertDTtoShortTime:(NSNumber *)timeNumber {
    
    double dtVal = [timeNumber doubleValue];
    /// convert from number to date
    NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:dtVal];
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:epochNSDate
                                                          dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    NSLog(@"dateString: %@", dateString);
    return dateString;
}

- (NSString *)convertFromKelvinToF:(NSNumber *)kelvins {

    double dVal = [kelvins doubleValue];
    
    double far = (dVal * 1.8) - 459.67;
    
    NSNumber *myDoubleNumber = [NSNumber numberWithDouble:far];
    
    NSString *numberString = [myDoubleNumber stringValue];
    
    return numberString;
}

- (UIImage *)returnIcon:(NSString *)iconCode {
    
    UIImage *icon;
    // ... code to calculate the number of characters ...
    if ([iconCode  isEqual: @"01d"]) {
        icon = [UIImage imageNamed:@"01d.png"];
    } else if ([iconCode  isEqual: @"02d"]) {
        icon = [UIImage imageNamed:@"02d.png"];
    } else if ([iconCode  isEqual: @"03d"]) {
        icon = [UIImage imageNamed:@"03d.png"];
    } else if ([iconCode  isEqual: @"04d"]) {
        icon = [UIImage imageNamed:@"04d.png"];
    } else if ([iconCode  isEqual: @"09d"]) {
        icon = [UIImage imageNamed:@"09d.png"];
    } else if ([iconCode  isEqual: @"10d"]) {
        icon = [UIImage imageNamed:@"10d.png"];
    } else if ([iconCode  isEqual: @"11d"]) {
        icon = [UIImage imageNamed:@"11d.png"];
    } else if ([iconCode  isEqual: @"13d"]) {
        icon = [UIImage imageNamed:@"13d.png"];
    } else if ([iconCode  isEqual: @"50d"]) {
        icon = [UIImage imageNamed:@"50d.png"];
    } else if ([iconCode  isEqual: @"01n"]) {
        icon = [UIImage imageNamed:@"01n.png"];
    } else if ([iconCode  isEqual: @"02n"]) {
        icon = [UIImage imageNamed:@"02n.png"];
    } else if ([iconCode  isEqual: @"03n"]) {
        icon = [UIImage imageNamed:@"03n.png"];
    } else if ([iconCode  isEqual: @"04n"]) {
        icon = [UIImage imageNamed:@"04n.png"];
    } else if ([iconCode  isEqual: @"09n"]) {
        icon = [UIImage imageNamed:@"09n.png"];
    } else if ([iconCode  isEqual: @"10n"]) {
        icon = [UIImage imageNamed:@"10n.png"];
    } else if ([iconCode  isEqual: @"11n"]) {
        icon = [UIImage imageNamed:@"11n.png"];
    } else if ([iconCode  isEqual: @"13n"]) {
        icon = [UIImage imageNamed:@"13n.png"];
    } else if ([iconCode  isEqual: @"50n"]) {
        icon = [UIImage imageNamed:@"50n.png"];
    }
    
    return icon;
  }

@end
