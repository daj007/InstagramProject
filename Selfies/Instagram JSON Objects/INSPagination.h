//
//  INSPagination.h
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface INSPagination : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nextMaxTagId;
@property (nonatomic, strong) NSString *nextUrl;
@property (nonatomic, strong) NSString *nextMaxId;
@property (nonatomic, strong) NSString *minTagId;
@property (nonatomic, strong) NSString *deprecationWarning;
@property (nonatomic, strong) NSString *nextMinId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
