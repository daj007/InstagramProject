//
//  INSThumbnail.m
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import "INSThumbnail.h"


NSString *const kINSThumbnailUrl = @"url";
NSString *const kINSThumbnailWidth = @"width";
NSString *const kINSThumbnailHeight = @"height";


@interface INSThumbnail ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation INSThumbnail

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
            self.url = [self objectOrNilForKey:kINSThumbnailUrl fromDictionary:dict];
            self.width = [[self objectOrNilForKey:kINSThumbnailWidth fromDictionary:dict] doubleValue];
            self.height = [[self objectOrNilForKey:kINSThumbnailHeight fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.url forKey:kINSThumbnailUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kINSThumbnailWidth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kINSThumbnailHeight];

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

    self.url = [aDecoder decodeObjectForKey:kINSThumbnailUrl];
    self.width = [aDecoder decodeDoubleForKey:kINSThumbnailWidth];
    self.height = [aDecoder decodeDoubleForKey:kINSThumbnailHeight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_url forKey:kINSThumbnailUrl];
    [aCoder encodeDouble:_width forKey:kINSThumbnailWidth];
    [aCoder encodeDouble:_height forKey:kINSThumbnailHeight];
}

- (id)copyWithZone:(NSZone *)zone
{
    INSThumbnail *copy = [[INSThumbnail alloc] init];
    
    if (copy) {

        copy.url = [self.url copyWithZone:zone];
        copy.width = self.width;
        copy.height = self.height;
    }
    
    return copy;
}


@end
