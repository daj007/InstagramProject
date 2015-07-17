//
//  INSData.h
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INSComments, INSCaption, INSLikes, INSLocation, INSImages, INSUser;

@interface INSData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *createdTime;
@property (nonatomic, strong) INSComments *comments;
@property (nonatomic, strong) INSCaption *caption;
@property (nonatomic, strong) NSArray *usersInPhoto;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) INSLikes *likes;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) INSLocation *location;
@property (nonatomic, strong) NSString *filter;
@property (nonatomic, strong) INSImages *images;
@property (nonatomic, strong) INSUser *user;
@property (nonatomic, assign) id attribution;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
