//
//  INSStandardResolution.m
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import "INSStandardResolution.h"


NSString *const kINSStandardResolutionUrl = @"url";
NSString *const kINSStandardResolutionWidth = @"width";
NSString *const kINSStandardResolutionHeight = @"height";


@interface INSStandardResolution ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation INSStandardResolution

@synthesize url = _url;
@synthesize width = _width;
@synthesize height = _height;


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
            self.url = [self objectOrNilForKey:kINSStandardResolutionUrl fromDictionary:dict];
            self.width = [[self objectOrNilForKey:kINSStandardResolutionWidth fromDictionary:dict] doubleValue];
            self.height = [[self objectOrNilForKey:kINSStandardResolutionHeight fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.url forKey:kINSStandardResolutionUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kINSStandardResolutionWidth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kINSStandardResolutionHeight];

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

    self.url = [aDecoder decodeObjectForKey:kINSStandardResolutionUrl];
    self.width = [aDecoder decodeDoubleForKey:kINSStandardResolutionWidth];
    self.height = [aDecoder decodeDoubleForKey:kINSStandardResolutionHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_url forKey:kINSStandardResolutionUrl];
    [aCoder encodeDouble:_width forKey:kINSStandardResolutionWidth];
    [aCoder encodeDouble:_height forKey:kINSStandardResolutionHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    INSStandardResolution *copy = [[INSStandardResolution alloc] init];
    
    if (copy) {

        copy.url = [self.url copyWithZone:zone];
        copy.width = self.width;
        copy.height = self.height;
    }
    
    return copy;
}


@end
