//
//  InstagramControllerViewController.h
//  Selfies
//
//  Created by MCS on 7/17/15.
//  Copyright © 2015 mobileConsultingSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"

@interface InstagramController : UIViewController

@property (nonatomic, assign) BOOL contentLoading;
@property (nonatomic, strong) NSString *hashtag;

-(void)instagramDataWithCompletionBlock:(void(^)(INSData2 *))completion;

@end
