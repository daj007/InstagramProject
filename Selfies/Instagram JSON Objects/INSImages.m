//
//  INSImages.m
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import "INSImages.h"
#import "INSLowResolution.h"
#import "INSStandardResolution.h"
#import "INSThumbnail.h"


NSString *const kINSImagesLowResolution = @"low_resolution";
NSString *const kINSImagesStandardResolution = @"standard_resolution";
NSString *const kINSImagesThumbnail = @"thumbnail";


@interface INSImages ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation INSImages

@synthesize lowResolution = _lowResolution;
@synthesize standardResolution = _standardResolution;
@synthesize thumbnail = _thumbnail;


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
            self.lowResolution = [INSLowResolution modelObjectWithDictionary:[dict objectForKey:kINSImagesLowResolution]];
            self.standardResolution = [INSStandardResolution modelObjectWithDictionary:[dict objectForKey:kINSImagesStandardResolution]];
            self.thumbnail = [INSThumbnail modelObjectWithDictionary:[dict objectForKey:kINSImagesThumbnail]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.lowResolution dictionaryRepresentation] forKey:kINSImagesLowResolution];
    [mutableDict setValue:[self.standardResolution dictionaryRepresentation] forKey:kINSImagesStandardResolution];
    [mutableDict setValue:[self.thumbnail dictionaryRepresentation] forKey:kINSImagesThumbnail];

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

    self.lowResolution = [aDecoder decodeObjectForKey:kINSImagesLowResolution];
    self.standardResolution = [aDecoder decodeObjectForKey:kINSImagesStandardResolution];
    self.thumbnail = [aDecoder decodeObjectForKey:kINSImagesThumbnail];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_lowResolution forKey:kINSImagesLowResolution];
    [aCoder encodeObject:_standardResolution forKey:kINSImagesStandardResolution];
    [aCoder encodeObject:_thumbnail forKey:kINSImagesThumbnail];
}

- (id)copyWithZone:(NSZone *)zone
{
    INSImages *copy = [[INSImages alloc] init];
    
    if (copy) {

        copy.lowResolution = [self.lowResolution copyWithZone:zone];
        copy.standardResolution = [self.standardResolution copyWithZone:zone];
        copy.thumbnail = [self.thumbnail copyWithZone:zone];
    }
    
    return copy;
}


@end
