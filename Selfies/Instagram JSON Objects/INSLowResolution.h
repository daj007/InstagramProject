//
//  INSLowResolution.h
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface INSLowResolution : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) double width;
@property (nonatomic, assign) double height;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
