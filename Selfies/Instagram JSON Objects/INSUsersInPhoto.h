//
//  INSUsersInPhoto.h
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INSPosition, INSUser;

@interface INSUsersInPhoto : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) INSPosition *position;
@property (nonatomic, strong) INSUser *user;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
