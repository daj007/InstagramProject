//
//  INSData2.m
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import "INSData2.h"
#import "INSMeta.h"
#import "INSData.h"
#import "INSPagination.h"


NSString *const kINSData2Meta = @"meta";
NSString *const kINSData2Data = @"data";
NSString *const kINSData2Pagination = @"pagination";


@interface INSData2 ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation INSData2

@synthesize meta = _meta;
@synthesize data = _data;
@synthesize pagination = _pagination;


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
            self.meta = [INSMeta modelObjectWithDictionary:[dict objectForKey:kINSData2Meta]];
    NSObject *receivedINSData = [dict objectForKey:kINSData2Data];
    NSMutableArray *parsedINSData = [NSMutableArray array];
    if ([receivedINSData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedINSData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedINSData addObject:[INSData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedINSData isKindOfClass:[NSDictionary class]]) {
       [parsedINSData addObject:[INSData modelObjectWithDictionary:(NSDictionary *)receivedINSData]];
    }

    self.data = [NSArray arrayWithArray:parsedINSData];
            self.pagination = [INSPagination modelObjectWithDictionary:[dict objectForKey:kINSData2Pagination]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.meta dictionaryRepresentation] forKey:kINSData2Meta];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kINSData2Data];
    [mutableDict setValue:[self.pagination dictionaryRepresentation] forKey:kINSData2Pagination];

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

    self.meta = [aDecoder decodeObjectForKey:kINSData2Meta];
    self.data = [aDecoder decodeObjectForKey:kINSData2Data];
    self.pagination = [aDecoder decodeObjectForKey:kINSData2Pagination];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_meta forKey:kINSData2Meta];
    [aCoder encodeObject:_data forKey:kINSData2Data];
    [aCoder encodeObject:_pagination forKey:kINSData2Pagination];
}

- (id)copyWithZone:(NSZone *)zone
{
    INSData2 *copy = [[INSData2 alloc] init];
    
    if (copy) {

        copy.meta = [self.meta copyWithZone:zone];
        copy.data = [self.data copyWithZone:zone];
        copy.pagination = [self.pagination copyWithZone:zone];
    }
    
    return copy;
}


@end
