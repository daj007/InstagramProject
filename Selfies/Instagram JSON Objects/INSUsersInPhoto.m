//
//  INSUsersInPhoto.m
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import "INSUsersInPhoto.h"
#import "INSPosition.h"
#import "INSUser.h"


NSString *const kINSUsersInPhotoPosition = @"position";
NSString *const kINSUsersInPhotoUser = @"user";


@interface INSUsersInPhoto ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation INSUsersInPhoto

@synthesize position = _position;
@synthesize user = _user;


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
            self.position = [INSPosition modelObjectWithDictionary:[dict objectForKey:kINSUsersInPhotoPosition]];
            self.user = [INSUser modelObjectWithDictionary:[dict objectForKey:kINSUsersInPhotoUser]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.position dictionaryRepresentation] forKey:kINSUsersInPhotoPosition];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kINSUsersInPhotoUser];

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

    self.position = [aDecoder decodeObjectForKey:kINSUsersInPhotoPosition];
    self.user = [aDecoder decodeObjectForKey:kINSUsersInPhotoUser];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_position forKey:kINSUsersInPhotoPosition];
    [aCoder encodeObject:_user forKey:kINSUsersInPhotoUser];
}

- (id)copyWithZone:(NSZone *)zone
{
    INSUsersInPhoto *copy = [[INSUsersInPhoto alloc] init];
    
    if (copy) {

        copy.position = [self.position copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
    }
    
    return copy;
}


@end
