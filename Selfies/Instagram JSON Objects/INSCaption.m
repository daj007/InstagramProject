//
//  INSCaption.m
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import "INSCaption.h"
#import "INSFrom.h"


NSString *const kINSCaptionText = @"text";
NSString *const kINSCaptionId = @"id";
NSString *const kINSCaptionCreatedTime = @"created_time";
NSString *const kINSCaptionFrom = @"from";


@interface INSCaption ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation INSCaption

@synthesize text = _text;
@synthesize captionIdentifier = _captionIdentifier;
@synthesize createdTime = _createdTime;
@synthesize from = _from;


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
            self.text = [self objectOrNilForKey:kINSCaptionText fromDictionary:dict];
            self.captionIdentifier = [self objectOrNilForKey:kINSCaptionId fromDictionary:dict];
            self.createdTime = [self objectOrNilForKey:kINSCaptionCreatedTime fromDictionary:dict];
            self.from = [INSFrom modelObjectWithDictionary:[dict objectForKey:kINSCaptionFrom]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.text forKey:kINSCaptionText];
    [mutableDict setValue:self.captionIdentifier forKey:kINSCaptionId];
    [mutableDict setValue:self.createdTime forKey:kINSCaptionCreatedTime];
    [mutableDict setValue:[self.from dictionaryRepresentation] forKey:kINSCaptionFrom];

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

    self.text = [aDecoder decodeObjectForKey:kINSCaptionText];
    self.captionIdentifier = [aDecoder decodeObjectForKey:kINSCaptionId];
    self.createdTime = [aDecoder decodeObjectForKey:kINSCaptionCreatedTime];
    self.from = [aDecoder decodeObjectForKey:kINSCaptionFrom];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_text forKey:kINSCaptionText];
    [aCoder encodeObject:_captionIdentifier forKey:kINSCaptionId];
    [aCoder encodeObject:_createdTime forKey:kINSCaptionCreatedTime];
    [aCoder encodeObject:_from forKey:kINSCaptionFrom];
}

- (id)copyWithZone:(NSZone *)zone
{
    INSCaption *copy = [[INSCaption alloc] init];
    
    if (copy) {

        copy.text = [self.text copyWithZone:zone];
        copy.captionIdentifier = [self.captionIdentifier copyWithZone:zone];
        copy.createdTime = [self.createdTime copyWithZone:zone];
        copy.from = [self.from copyWithZone:zone];
    }
    
    return copy;
}


@end
