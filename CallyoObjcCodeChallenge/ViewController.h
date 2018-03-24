//
//  ViewController.h
//  CallyoObjcCodeChallenge
//
//  Created by Anthony on 3/24/18.
//  Copyright © 2018 Anthony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *weatherTableView;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@end

