////
////  WeatherGetter.m
////  CallyoObjcCodeChallenge
////
////  Created by Anthony on 3/24/18.
////  Copyright © 2018 Anthony. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//
//@interface WeatherGetter:NSObject
///* method declaration */
//- (void)makeURL:(NSString*)city;
//@end
//
//@implementation WeatherGetter
//
//NSString *baseURL = @"https://api.openweathermap.org/data/2.5/forecast?";
//
//NSString *queryParameter = @"q=";
//
//NSString *appIDParameter = @"&appid=";
//
///// replace this with valid API key
//NSString *apiKey = @"fc490ca55b05ce6da7b75de78fc86cc6";
//
//NSString *defaultCity = @"New York";
//
///* method returning the max between two numbers */
//- (void)makeURL:(NSString*)city {
//    /* local variable declaration */
//    NSString *encodedCityString;
//
//    NSUInteger length = [city length];
//    
////        //Mark: check input text count and replace empty spaces with %encoding
//            if (length < 1) {
//                NSString *encodedCityString = [defaultCity stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//            } else {
//                NSString *encodedCityString = [city stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//            }
//    
//    NSString *urlString = baseURL; queryParameter; encodedCityString; appIDParameter; apiKey;
//    
//    NSURL *newURL = [NSURL URLWithString:urlString];
//    
//    NSLog(newURL);
//    //        let newURLRequst = URLRequest(url: newURL!)
//
//    /// this should be a url request
////    return encodedCityString;
//    
//}
//
//@end
//
////int main ()
////{
////    /* local variable definition */
////    int a = 100;
////    int b = 200;
////    int ret;
////
////    WeatherGetter *weatherGetter = [[WeatherGetter alloc]init];
////
////    /* calling a method to get max value */
////    ret = [weatherGetter max:a andNum2:b];
////
////    NSLog(@"Max value is : %d\n", ret );
////
////    return 0;
////}
//
