//
//  INSUser.m
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import "INSUser.h"


NSString *const kINSUserUsername = @"username";
NSString *const kINSUserId = @"id";
NSString *const kINSUserProfilePicture = @"profile_picture";
NSString *const kINSUserFullName = @"full_name";


@interface INSUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation INSUser

@synthesize username = _username;
@synthesize userIdentifier = _userIdentifier;
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
            self.username = [self objectOrNilForKey:kINSUserUsername fromDictionary:dict];
            self.userIdentifier = [self objectOrNilForKey:kINSUserId fromDictionary:dict];
            self.profilePicture = [self objectOrNilForKey:kINSUserProfilePicture fromDictionary:dict];
            self.fullName = [self objectOrNilForKey:kINSUserFullName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.username forKey:kINSUserUsername];
    [mutableDict setValue:self.userIdentifier forKey:kINSUserId];
    [mutableDict setValue:self.profilePicture forKey:kINSUserProfilePicture];
    [mutableDict setValue:self.fullName forKey:kINSUserFullName];

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

    self.username = [aDecoder decodeObjectForKey:kINSUserUsername];
    self.userIdentifier = [aDecoder decodeObjectForKey:kINSUserId];
    self.profilePicture = [aDecoder decodeObjectForKey:kINSUserProfilePicture];
    self.fullName = [aDecoder decodeObjectForKey:kINSUserFullName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_username forKey:kINSUserUsername];
    [aCoder encodeObject:_userIdentifier forKey:kINSUserId];
    [aCoder encodeObject:_profilePicture forKey:kINSUserProfilePicture];
    [aCoder encodeObject:_fullName forKey:kINSUserFullName];
}

- (id)copyWithZone:(NSZone *)zone
{
    INSUser *copy = [[INSUser alloc] init];
    
    if (copy) {

        copy.username = [self.username copyWithZone:zone];
        copy.userIdentifier = [self.userIdentifier copyWithZone:zone];
        copy.profilePicture = [self.profilePicture copyWithZone:zone];
        copy.fullName = [self.fullName copyWithZone:zone];
    }
    
    return copy;
}


@end
