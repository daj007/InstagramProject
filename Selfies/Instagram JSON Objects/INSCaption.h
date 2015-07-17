//
//  INSCaption.h
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INSFrom;

@interface INSCaption : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *captionIdentifier;
@property (nonatomic, strong) NSString *createdTime;
@property (nonatomic, strong) INSFrom *from;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
