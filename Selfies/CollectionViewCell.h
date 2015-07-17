//
//  CollectionViewCell.h
//  Selfies
//
//  Created by MCS on 7/17/15.
//  Copyright © 2015 mobileConsultingSolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSmall1;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewSmall2;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProfile;
@property (weak, nonatomic) IBOutlet UILabel *userLbl;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (nonatomic, strong) NSString *identifier;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator2;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator3;

@end
