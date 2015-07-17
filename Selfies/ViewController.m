//
//  ViewController.m
//  Selfies
//
//  Created by MCS on 7/17/15.
//  Copyright © 2015 mobileConsultingSolutions. All rights reserved.
//

#import "ViewController.h"
#import "ViewController.h"
#import "CollectionViewCell.h"
#import "DetailViewController.h"
#import "InstagramController.h"

static NSString *const alertTitle = @"Connection error";
static NSString *const alertMessage = @"We can't seem to reach the server. Please, try again.";
static NSString *const alertButtonTitle = @"Try again";

static NSString *const kLowResImageSuffix = @"low_resolution";
static NSString *const kThumbImageSuffix = @"thumbnail";
static NSString *const kProfilePicSuffix = @"profile_pic";

static CGFloat const yOffsetAdjustment = 2000;

@interface ViewController () <NSURLConnectionDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *instagramArray;
@property (nonatomic, strong) NSMutableDictionary *cachedImages;
@property (nonatomic, strong) InstagramController *instagramController;
@property (weak, nonatomic) IBOutlet UITextField *hashtagField;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.cachedImages = [NSMutableDictionary dictionary];
    
    self.instagramController = [[InstagramController alloc]init];
    
    self.instagramArray = [NSMutableArray array];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:181.0/256.0 green:232.0/256.0 blue:253.0/256.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self searchWithHashTag:@"selfie"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Load Data

-(void)loadInstagramData
{
    if(self.instagramArray.count == 0)
    {
        self.instagramController.contentLoading = YES;
        
        [self.collectionView reloadData];
    }
    [self.instagramController instagramDataWithCompletionBlock:^(INSData2 *data){
        if(data)
        {
            [self.instagramArray addObjectsFromArray:data.data];
            [self.collectionView reloadData];
        }
        else
        {
            [self.collectionView reloadData];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:alertTitle
                                                                           message:alertMessage
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:alertButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [self loadInstagramData];
            }]];
            
            [self.navigationController presentViewController:alert animated:YES completion:nil];
        }
    }];
}

#pragma mark - Scroll Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.instagramController.contentLoading == NO && self.instagramArray.count > 0)
    {
        if(scrollView.contentOffset.y >= scrollView.contentSize.height - yOffsetAdjustment)
        {
            [self loadInstagramData];
        }
    }
    
    //Determine scrolling direction
    
    NSNumber *lastContentOffsetNumber;
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"lastContentOffset"])
    {
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:0.0] forKey:@"lastContentOffset" ];
    }
    
    lastContentOffsetNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"lastContentOffset"];
    
    CGFloat lastContentOffset = [lastContentOffsetNumber floatValue];
    CGFloat currentContentOffset = scrollView.contentOffset.y;
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithFloat:currentContentOffset] forKey:@"lastContentOffset" ];
    
    BOOL scrollingDown = NO;
    
    if(lastContentOffset < currentContentOffset)
    {
        scrollingDown = YES;
    }
    
    //Updating NavigationBar and Content frame
    
    UINavigationBar *navbar = self.navigationController.navigationBar;
    UIView *content = self.view;
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    
    CGRect contentFrame = self.view.frame;
    
    if(scrollingDown)
    {
        navBarFrame.origin.y = MIN(0, MAX(-44, (currentContentOffset * -1))) + 20 ;
    }
    else
    {
        navBarFrame.origin.y = MIN(0, MAX(-44, (lastContentOffset * -1))) + 20 ;
    }
    CGFloat originDifference = contentFrame.origin.y - (navBarFrame.origin.y + navBarFrame.size.height);
    contentFrame.origin.y = navBarFrame.origin.y + navBarFrame.size.height;
    
    contentFrame.size.height = contentFrame.size.height + originDifference;
    
    CGFloat alpha = (navBarFrame.origin.y + 24)/36;
    
    for (UIView *subview in self.navigationController.navigationBar.subviews)
    {
        if([subview isKindOfClass:[UITextField class]]
           || [subview isKindOfClass:[UIBarButtonItem class]]
           || [subview isKindOfClass:[UIButton class]]
           || [subview isKindOfClass:[UILabel class]]
           || [subview isKindOfClass:[UISegmentedControl class]]
           || [subview isKindOfClass:[UIStepper class]]
           || [subview isKindOfClass:[UISlider class]])
        {
            subview.alpha = alpha;
        }
    }
    
    navbar.frame = navBarFrame;
    content.frame = contentFrame;
    
    [self.navigationController.view endEditing:YES];
    [self.navigationController.view resignFirstResponder];
}

#pragma mark - CollectionView Data Source
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.instagramArray.count > 0 || self.instagramController.contentLoading)
    {
        return self.instagramArray.count + 1;
    }
    else
    {
        return 0;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < self.instagramArray.count)
    {
        CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        INSData *instagramData = self.instagramArray[indexPath.row];
        
        NSString *identifier = instagramData.dataIdentifier;
        
        cell.userLbl.text =instagramData.user.username;
        cell.descriptionLbl.attributedText = [self decorateTags:instagramData.caption.text];
        
        [cell.activityIndicator1 startAnimating];
        [cell.activityIndicator2 startAnimating];
        [cell.activityIndicator3 startAnimating];
        
        cell.activityIndicator1.hidden = NO;
        cell.activityIndicator2.hidden = NO;
        cell.activityIndicator3.hidden = NO;
        
        if([self.cachedImages objectForKey:[NSString stringWithFormat:@"%@_%@", identifier, kLowResImageSuffix]]
           && [self.cachedImages objectForKey:[NSString stringWithFormat:@"%@_%@", identifier, kThumbImageSuffix]]
           && [self.cachedImages objectForKey:[NSString stringWithFormat:@"%@_%@", identifier, kProfilePicSuffix]])
        {
            [cell.activityIndicator1 stopAnimating];
            [cell.activityIndicator2 stopAnimating];
            [cell.activityIndicator3 stopAnimating];
            
            cell.activityIndicator1.hidden = YES;
            cell.activityIndicator2.hidden = YES;
            cell.activityIndicator3.hidden = YES;
            
            cell.imageView.image = [self.cachedImages objectForKey:[NSString stringWithFormat:@"%@_%@", identifier, kLowResImageSuffix]];
            cell.imageViewSmall1.image = [self.cachedImages objectForKey:[NSString stringWithFormat:@"%@_%@", identifier, kThumbImageSuffix]];
            cell.imageViewSmall2.image = [self.cachedImages objectForKey:[NSString stringWithFormat:@"%@_%@", identifier, kThumbImageSuffix]];
            cell.imageViewProfile.image = [self.cachedImages objectForKey:[NSString stringWithFormat:@"%@_%@", identifier, kProfilePicSuffix]];
        }
        else
        {
            cell.imageView.image = nil;
            cell.imageViewSmall1.image = nil;
            cell.imageViewSmall2.image = nil;
            cell.imageViewProfile.image = nil;
            
            cell.imageView.backgroundColor = [UIColor whiteColor];
            cell.imageViewSmall1.backgroundColor = [UIColor whiteColor];
            cell.imageViewSmall2.backgroundColor = [UIColor whiteColor];
            cell.imageViewProfile.backgroundColor = [UIColor whiteColor];
            
            dispatch_queue_t queue = dispatch_queue_create([identifier UTF8String], 0);
            
            dispatch_async(queue, ^{
                
                NSString *thumbnail = instagramData.images.thumbnail.url;
                
                NSURL *imageThumbnailURL = [NSURL URLWithString:thumbnail];
                NSData *imageThumbnailData = [NSData dataWithContentsOfURL:imageThumbnailURL];
                UIImage *imageThumbnail = [UIImage imageWithData:imageThumbnailData];
                
                NSString *lowRes = instagramData.images.lowResolution.url;
                
                NSURL *imageLowResURL = [NSURL URLWithString:lowRes];
                NSData *imageLowResData = [NSData dataWithContentsOfURL:imageLowResURL];
                UIImage *imageLowRes = [UIImage imageWithData:imageLowResData];
                
                NSString *profPic = instagramData.user.profilePicture;
                
                NSURL *imageProfPicURL = [NSURL URLWithString:profPic];
                NSData *imageProfPicData = [NSData dataWithContentsOfURL:imageProfPicURL];
                UIImage *imageProfPic = [UIImage imageWithData:imageProfPicData];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([collectionView indexPathForCell:cell].row == indexPath.row)
                    {
                        [self.cachedImages setValue:imageLowRes forKey:[NSString stringWithFormat:@"%@_%@", identifier, kLowResImageSuffix]];
                        [self.cachedImages setValue:imageThumbnail forKey:[NSString stringWithFormat:@"%@_%@", identifier, kThumbImageSuffix]];
                        [self.cachedImages setValue:imageThumbnail forKey:[NSString stringWithFormat:@"%@_%@", identifier, kProfilePicSuffix]];
                        
                        cell.imageView.image = imageLowRes;
                        cell.imageViewSmall1.image = imageThumbnail;
                        cell.imageViewSmall2.image = imageThumbnail;
                        cell.imageViewProfile.image = imageProfPic;
                        
                        [cell.activityIndicator1 stopAnimating];
                        [cell.activityIndicator2 stopAnimating];
                        [cell.activityIndicator3 stopAnimating];
                        
                        cell.activityIndicator1.hidden = YES;
                        cell.activityIndicator2.hidden = YES;
                        cell.activityIndicator3.hidden = YES;
                    }
                });
            });
        }
        
        return cell;
    }
    else
    {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loadingData" forIndexPath:indexPath];
        
        return cell;
    }
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue destinationViewController] isKindOfClass:[DetailViewController class]])
    {
        DetailViewController *dvc = (DetailViewController *)[segue destinationViewController];
        
        NSInteger index = [[[self.collectionView indexPathsForSelectedItems] firstObject] row];
        
        INSData *instagramData = self.instagramArray[index];
        
        dvc.user = instagramData.user.username;
        dvc.caption = instagramData.caption.text;
        
        NSString *stdRes = instagramData.images.standardResolution.url;
        
        NSURL *imageStdResURL = [NSURL URLWithString:stdRes];
        NSData *imageStdResData = [NSData dataWithContentsOfURL:imageStdResURL];
        UIImage *imageStdRes = [UIImage imageWithData:imageStdResData];
        
        NSString *profPic = instagramData.user.profilePicture;
        
        NSURL *imageProfPicURL = [NSURL URLWithString:profPic];
        NSData *imageProfPicData = [NSData dataWithContentsOfURL:imageProfPicURL];
        UIImage *imageProfPic = [UIImage imageWithData:imageProfPicData];
        
        dvc.profilePicImg = imageProfPic;
        dvc.image = imageStdRes;
    }
}
- (IBAction)search:(id)sender
{
    [self searchHashtag];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if([textField isEqual:self.hashtagField])
    {
        [self searchHashtag];
    }
    
    return YES;
}

-(void)searchHashtag
{
    NSString *hashtag = [self.hashtagField.text mutableCopy];
    if(hashtag.length > 0)
    {
        hashtag = [self string:hashtag ByReplacingOccurancesOfSubstring:@"#"];
        hashtag = [self string:hashtag ByReplacingOccurancesOfSubstring:@"&"];
        hashtag = [self string:hashtag ByReplacingOccurancesOfSubstring:@" "];
        
        [self searchWithHashTag:hashtag];
        
    }
}

-(void)searchWithHashTag:(NSString*)hashtag {
    NSLog(@"%@", hashtag);
    
    self.instagramController.hashtag = hashtag;
    
    [self.navigationController.view endEditing:YES];
    [self.navigationController.view resignFirstResponder];
    
    [self.instagramArray removeAllObjects];
    
    [self.collectionView reloadData];
    
    [self loadInstagramData];
}

-(NSString *)string:(NSString *)string ByReplacingOccurancesOfSubstring:(NSString *)substring
{
    NSRange replaceRange = [string rangeOfString:substring];
    if (replaceRange.location != NSNotFound){
        return [string stringByReplacingCharactersInRange:replaceRange withString:@""];
    }
    return string;
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
        UIFont *font=[UIFont fontWithName:@"Helvetica-light" size:11.0f];
        [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, stringLength)];
        
        
        //Set Background Color
        
        //Set Foreground Color
        UIColor *foregroundColor = [UIColor colorWithRed:35.0/256.0 green:161.0/256.0 blue:246.0/256.0 alpha:1];
        [attString addAttribute:NSForegroundColorAttributeName value:foregroundColor range:wordRange];
        
    }
    
    return attString;
}

@end