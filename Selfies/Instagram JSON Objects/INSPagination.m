//
//  INSPagination.m
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import "INSPagination.h"


NSString *const kINSPaginationNextMaxTagId = @"next_max_tag_id";
NSString *const kINSPaginationNextUrl = @"next_url";
NSString *const kINSPaginationNextMaxId = @"next_max_id";
NSString *const kINSPaginationMinTagId = @"min_tag_id";
NSString *const kINSPaginationDeprecationWarning = @"deprecation_warning";
NSString *const kINSPaginationNextMinId = @"next_min_id";


@interface INSPagination ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation INSPagination

@synthesize nextMaxTagId = _nextMaxTagId;
@synthesize nextUrl = _nextUrl;
@synthesize nextMaxId = _nextMaxId;
@synthesize minTagId = _minTagId;
@synthesize deprecationWarning = _deprecationWarning;
@synthesize nextMinId = _nextMinId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.nextMaxTagId = [self objectOrNilForKey:kINSPaginationNextMaxTagId fromDictionary:dict];
            self.nextUrl = [self objectOrNilForKey:kINSPaginationNextUrl fromDictionary:dict];
            self.nextMaxId = [self objectOrNilForKey:kINSPaginationNextMaxId fromDictionary:dict];
            self.minTagId = [self objectOrNilForKey:kINSPaginationMinTagId fromDictionary:dict];
            self.deprecationWarning = [self objectOrNilForKey:kINSPaginationDeprecationWarning fromDictionary:dict];
            self.nextMinId = [self objectOrNilForKey:kINSPaginationNextMinId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nextMaxTagId forKey:kINSPaginationNextMaxTagId];
    [mutableDict setValue:self.nextUrl forKey:kINSPaginationNextUrl];
    [mutableDict setValue:self.nextMaxId forKey:kINSPaginationNextMaxId];
    [mutableDict setValue:self.minTagId forKey:kINSPaginationMinTagId];
    [mutableDict setValue:self.deprecationWarning forKey:kINSPaginationDeprecationWarning];
    [mutableDict setValue:self.nextMinId forKey:kINSPaginationNextMinId];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.nextMaxTagId = [aDecoder decodeObjectForKey:kINSPaginationNextMaxTagId];
    self.nextUrl = [aDecoder decodeObjectForKey:kINSPaginationNextUrl];
    self.nextMaxId = [aDecoder decodeObjectForKey:kINSPaginationNextMaxId];
    self.minTagId = [aDecoder decodeObjectForKey:kINSPaginationMinTagId];
    self.deprecationWarning = [aDecoder decodeObjectForKey:kINSPaginationDeprecationWarning];
    self.nextMinId = [aDecoder decodeObjectForKey:kINSPaginationNextMinId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nextMaxTagId forKey:kINSPaginationNextMaxTagId];
    [aCoder encodeObject:_nextUrl forKey:kINSPaginationNextUrl];
    [aCoder encodeObject:_nextMaxId forKey:kINSPaginationNextMaxId];
    [aCoder encodeObject:_minTagId forKey:kINSPaginationMinTagId];
    [aCoder encodeObject:_deprecationWarning forKey:kINSPaginationDeprecationWarning];
    [aCoder encodeObject:_nextMinId forKey:kINSPaginationNextMinId];
}

- (id)copyWithZone:(NSZone *)zone
{
    INSPagination *copy = [[INSPagination alloc] init];
    
    if (copy) {

        copy.nextMaxTagId = [self.nextMaxTagId copyWithZone:zone];
        copy.nextUrl = [self.nextUrl copyWithZone:zone];
        copy.nextMaxId = [self.nextMaxId copyWithZone:zone];
        copy.minTagId = [self.minTagId copyWithZone:zone];
        copy.deprecationWarning = [self.deprecationWarning copyWithZone:zone];
        copy.nextMinId = [self.nextMinId copyWithZone:zone];
    }
    
    return copy;
}


@end
