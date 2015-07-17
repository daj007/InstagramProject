//
//  INSData2.h
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INSMeta, INSPagination;

@interface INSData2 : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) INSMeta *meta;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) INSPagination *pagination;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
