//
//  INSLowResolution.m
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import "INSLowResolution.h"


NSString *const kINSLowResolutionUrl = @"url";
NSString *const kINSLowResolutionWidth = @"width";
NSString *const kINSLowResolutionHeight = @"height";


@interface INSLowResolution ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation INSLowResolution

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
            self.url = [self objectOrNilForKey:kINSLowResolutionUrl fromDictionary:dict];
            self.width = [[self objectOrNilForKey:kINSLowResolutionWidth fromDictionary:dict] doubleValue];
            self.height = [[self objectOrNilForKey:kINSLowResolutionHeight fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.url forKey:kINSLowResolutionUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kINSLowResolutionWidth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kINSLowResolutionHeight];

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

    self.url = [aDecoder decodeObjectForKey:kINSLowResolutionUrl];
    self.width = [aDecoder decodeDoubleForKey:kINSLowResolutionWidth];
    self.height = [aDecoder decodeDoubleForKey:kINSLowResolutionHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_url forKey:kINSLowResolutionUrl];
    [aCoder encodeDouble:_width forKey:kINSLowResolutionWidth];
    [aCoder encodeDouble:_height forKey:kINSLowResolutionHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    INSLowResolution *copy = [[INSLowResolution alloc] init];
    
    if (copy) {

        copy.url = [self.url copyWithZone:zone];
        copy.width = self.width;
        copy.height = self.height;
    }
    
    return copy;
}


@end
