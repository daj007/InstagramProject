//
//  INSPosition.m
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import "INSPosition.h"


NSString *const kINSPositionY = @"y";
NSString *const kINSPositionX = @"x";


@interface INSPosition ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation INSPosition

@synthesize y = _y;
@synthesize x = _x;


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
            self.y = [[self objectOrNilForKey:kINSPositionY fromDictionary:dict] doubleValue];
            self.x = [[self objectOrNilForKey:kINSPositionX fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.y] forKey:kINSPositionY];
    [mutableDict setValue:[NSNumber numberWithDouble:self.x] forKey:kINSPositionX];

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

    self.y = [aDecoder decodeDoubleForKey:kINSPositionY];
    self.x = [aDecoder decodeDoubleForKey:kINSPositionX];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_y forKey:kINSPositionY];
    [aCoder encodeDouble:_x forKey:kINSPositionX];
}

- (id)copyWithZone:(NSZone *)zone
{
    INSPosition *copy = [[INSPosition alloc] init];
    
    if (copy) {

        copy.y = self.y;
        copy.x = self.x;
    }
    
    return copy;
}


@end
