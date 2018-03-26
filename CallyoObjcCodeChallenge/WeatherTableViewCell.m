//
//  WeatherTableViewCell.m
//  CallyoObjcCodeChallenge
//
//  Created by Anthony on 3/25/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

#import "WeatherTableViewCell.h"

@implementation WeatherTableViewCell

@synthesize humidityLabel;
@synthesize descriptionLabel;
@synthesize tempHighLabel;
@synthesize tempLowLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
