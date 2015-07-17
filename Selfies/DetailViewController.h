//
//  DetailViewController.h
//  Selfies
//
//  Created by MCS on 7/17/15.
//  Copyright © 2015 mobileConsultingSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *caption;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) UIImage *profilePicImg;

@end
