//
//  INSFrom.m
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import "INSFrom.h"


NSString *const kINSFromUsername = @"username";
NSString *const kINSFromId = @"id";
NSString *const kINSFromProfilePicture = @"profile_picture";
NSString *const kINSFromFullName = @"full_name";


@interface INSFrom ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation INSFrom

@synthesize username = _username;
@synthesize fromIdentifier = _fromIdentifier;
@synthesize profilePicture = _profilePicture;
@synthesize fullName = _fullName;


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
            self.username = [self objectOrNilForKey:kINSFromUsername fromDictionary:dict];
            self.fromIdentifier = [self objectOrNilForKey:kINSFromId fromDictionary:dict];
            self.profilePicture = [self objectOrNilForKey:kINSFromProfilePicture fromDictionary:dict];
            self.fullName = [self objectOrNilForKey:kINSFromFullName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.username forKey:kINSFromUsername];
    [mutableDict setValue:self.fromIdentifier forKey:kINSFromId];
    [mutableDict setValue:self.profilePicture forKey:kINSFromProfilePicture];
    [mutableDict setValue:self.fullName forKey:kINSFromFullName];

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

    self.username = [aDecoder decodeObjectForKey:kINSFromUsername];
    self.fromIdentifier = [aDecoder decodeObjectForKey:kINSFromId];
    self.profilePicture = [aDecoder decodeObjectForKey:kINSFromProfilePicture];
    self.fullName = [aDecoder decodeObjectForKey:kINSFromFullName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_username forKey:kINSFromUsername];
    [aCoder encodeObject:_fromIdentifier forKey:kINSFromId];
    [aCoder encodeObject:_profilePicture forKey:kINSFromProfilePicture];
    [aCoder encodeObject:_fullName forKey:kINSFromFullName];
}

- (id)copyWithZone:(NSZone *)zone
{
    INSFrom *copy = [[INSFrom alloc] init];
    
    if (copy) {

        copy.username = [self.username copyWithZone:zone];
        copy.fromIdentifier = [self.fromIdentifier copyWithZone:zone];
        copy.profilePicture = [self.profilePicture copyWithZone:zone];
        copy.fullName = [self.fullName copyWithZone:zone];
    }
    
    return copy;
}


@end
