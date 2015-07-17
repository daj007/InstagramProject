//
//  DetailViewController.m
//  Selfies
//
//  Created by MCS on 7/17/15.
//  Copyright © 2015 mobileConsultingSolutions. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation DetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.username.text = self.user;
    self.descriptionLbl.attributedText = [self decorateTags:self.caption];
    self.imageView.image = self.image;
    self.profilePic.image = self.profilePicImg;
    self.scrollView.contentSize = self.image.size;
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 1;
    self.scrollView.maximumZoomScale = 100;
    
    //self.navigationController.hidesBarsOnSwipe = NO;
    
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    
    navBarFrame.origin.y = 20;
    
    self.navigationController.navigationBar.frame = navBarFrame;
}

-(NSMutableAttributedString*)decorateTags:(NSString *)stringWithTags
{
    
    NSError *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"#(\\w+)" options:0 error:&error];
    
    NSArray *matches = [regex matchesInString:stringWithTags options:0 range:NSMakeRange(0, stringWithTags.length)];
    NSMutableAttributedString *attString=[[NSMutableAttributedString alloc] initWithString:stringWithTags];
    
    NSInteger stringLength=[stringWithTags length];
    
    for (NSTextCheckingResult *match in matches) {
        
        NSRange wordRange = [match rangeAtIndex:1];
        //
        //        NSString* word = [stringWithTags substringWithRange:wordRange];
        
        //Set Font
        UIFont *font=[UIFont fontWithName:@"Helvetica-light" size:14.0f];
        [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, stringLength)];
        
        
        //Set Background Color
        
        //Set Foreground Color
        UIColor *foregroundColor = [UIColor colorWithRed:35.0/256.0 green:161.0/256.0 blue:246.0/256.0 alpha:1];
        [attString addAttribute:NSForegroundColorAttributeName value:foregroundColor range:wordRange];
    }
    
    return attString;
}

-(nullable UIView *)viewForZoomingInScrollView:(nonnull UIScrollView *)scrollView {
    return self.imageView;
}

@end