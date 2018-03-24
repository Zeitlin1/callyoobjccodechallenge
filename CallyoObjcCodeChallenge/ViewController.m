//
//  ViewController.m
//  CallyoObjcCodeChallenge
//
//  Created by Anthony on 3/24/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

{
    NSMutableArray *weatherData;
}

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
    
    if ([self.searchTextField.text  isEqual: @""]) {
       
        NSLog(@"text empty");
        
        static NSString *defaultString = @"New York";
        
        
    } else {
        
//        self.searchTextField.text
        
         NSLog(@"Button Pushed & text not empty");
        
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
