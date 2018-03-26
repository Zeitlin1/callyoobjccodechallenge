//
//  WeatherTableViewCell.h
//  CallyoObjcCodeChallenge
//
//  Created by Anthony on 3/25/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *tempHighLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLowLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
