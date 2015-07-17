//
//  InstagramControllerViewController.m
//  Selfies
//
//  Created by MCS on 7/17/15.
//  Copyright © 2015 mobileConsultingSolutions. All rights reserved.
//

#import "InstagramController.h"

static NSTimeInterval const requestTimeout = 10.0;

@interface InstagramController ()

@property (nonatomic, strong) NSString *urlString;

@end

@implementation InstagramController

-(instancetype)initWithHashtag:(NSString *)hashtag
{
    if(self = [super init])
    {
        _hashtag = hashtag;
        _urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=ad7fd785c94d41878ff8e38c85e2af00", _hashtag];
        _contentLoading = NO;
    }
    return self;
}

-(void)setHashtag:(NSString *)hashtag
{
    _hashtag = hashtag;
    self.urlString = [NSString stringWithFormat:@"https://api.instagram.com/v1/tags/%@/media/recent?client_id=ad7fd785c94d41878ff8e38c85e2af00", _hashtag];
}


-(void)instagramDataWithCompletionBlock:(void(^)(INSData2 *))completion
{
    self.contentLoading = YES;
    NSURL *url = [NSURL URLWithString:self.urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval: requestTimeout];
    NSLog(@"URL: %@", self.urlString);
    NSLog(@"Requesting content...");
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               if (data != nil && error == nil)
                               {
                                   NSLog(@"Content received.");
                                   NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                                   
                                   INSData2 *data = [[INSData2 alloc]initWithDictionary:jsonResult];
                                   
                                   self.urlString = data.pagination.nextUrl;
                                   
                                   self.contentLoading = NO;
                                   completion(data);
                                   
                               }
                               else
                               {
                                   NSLog(@"Request error.");
                                   self.contentLoading = NO;
                                   completion(nil);
                               }
                               
                           }];
}

@end

