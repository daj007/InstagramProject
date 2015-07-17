//
//  INSLocation.m
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import "INSLocation.h"


NSString *const kINSLocationLongitude = @"longitude";
NSString *const kINSLocationLatitude = @"latitude";


@interface INSLocation ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation INSLocation

@synthesize longitude = _longitude;
@synthesize latitude = _latitude;


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
            self.longitude = [[self objectOrNilForKey:kINSLocationLongitude fromDictionary:dict] doubleValue];
            self.latitude = [[self objectOrNilForKey:kINSLocationLatitude fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.longitude] forKey:kINSLocationLongitude];
    [mutableDict setValue:[NSNumber numberWithDouble:self.latitude] forKey:kINSLocationLatitude];

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

    self.longitude = [aDecoder decodeDoubleForKey:kINSLocationLongitude];
    self.latitude = [aDecoder decodeDoubleForKey:kINSLocationLatitude];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_longitude forKey:kINSLocationLongitude];
    [aCoder encodeDouble:_latitude forKey:kINSLocationLatitude];
}

- (id)copyWithZone:(NSZone *)zone
{
    INSLocation *copy = [[INSLocation alloc] init];
    
    if (copy) {

        copy.longitude = self.longitude;
        copy.latitude = self.latitude;
    }
    
    return copy;
}


@end
