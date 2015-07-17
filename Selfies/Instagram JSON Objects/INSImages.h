//
//  INSImages.h
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INSLowResolution, INSStandardResolution, INSThumbnail;

@interface INSImages : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) INSLowResolution *lowResolution;
@property (nonatomic, strong) INSStandardResolution *standardResolution;
@property (nonatomic, strong) INSThumbnail *thumbnail;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
