//
//  INSData.m
//
//  Created by David Amezcua on 7/17/15
//  Copyright (c) 2015 Mobile Consulting Solutions. All rights reserved.
//

#import "INSData.h"
#import "INSComments.h"
#import "INSCaption.h"
#import "INSLikes.h"
#import "INSLocation.h"
#import "INSImages.h"
#import "INSUser.h"


NSString *const kINSDataId = @"id";
NSString *const kINSDataCreatedTime = @"created_time";
NSString *const kINSDataComments = @"comments";
NSString *const kINSDataCaption = @"caption";
NSString *const kINSDataUsersInPhoto = @"users_in_photo";
NSString *const kINSDataLink = @"link";
NSString *const kINSDataLikes = @"likes";
NSString *const kINSDataType = @"type";
NSString *const kINSDataTags = @"tags";
NSString *const kINSDataLocation = @"location";
NSString *const kINSDataFilter = @"filter";
NSString *const kINSDataImages = @"images";
NSString *const kINSDataUser = @"user";
NSString *const kINSDataAttribution = @"attribution";


@interface INSData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation INSData

@synthesize dataIdentifier = _dataIdentifier;
@synthesize createdTime = _createdTime;
@synthesize comments = _comments;
@synthesize caption = _caption;
@synthesize usersInPhoto = _usersInPhoto;
@synthesize link = _link;
@synthesize likes = _likes;
@synthesize type = _type;
@synthesize tags = _tags;
@synthesize location = _location;
@synthesize filter = _filter;
@synthesize images = _images;
@synthesize user = _user;
@synthesize attribution = _attribution;


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
            self.dataIdentifier = [self objectOrNilForKey:kINSDataId fromDictionary:dict];
            self.createdTime = [self objectOrNilForKey:kINSDataCreatedTime fromDictionary:dict];
            self.comments = [INSComments modelObjectWithDictionary:[dict objectForKey:kINSDataComments]];
            self.caption = [INSCaption modelObjectWithDictionary:[dict objectForKey:kINSDataCaption]];
            self.usersInPhoto = [self objectOrNilForKey:kINSDataUsersInPhoto fromDictionary:dict];
            self.link = [self objectOrNilForKey:kINSDataLink fromDictionary:dict];
            self.likes = [INSLikes modelObjectWithDictionary:[dict objectForKey:kINSDataLikes]];
            self.type = [self objectOrNilForKey:kINSDataType fromDictionary:dict];
            self.tags = [self objectOrNilForKey:kINSDataTags fromDictionary:dict];
            self.location = [INSLocation modelObjectWithDictionary:[dict objectForKey:kINSDataLocation]];
            self.filter = [self objectOrNilForKey:kINSDataFilter fromDictionary:dict];
            self.images = [INSImages modelObjectWithDictionary:[dict objectForKey:kINSDataImages]];
            self.user = [INSUser modelObjectWithDictionary:[dict objectForKey:kINSDataUser]];
            self.attribution = [self objectOrNilForKey:kINSDataAttribution fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.dataIdentifier forKey:kINSDataId];
    [mutableDict setValue:self.createdTime forKey:kINSDataCreatedTime];
    [mutableDict setValue:[self.comments dictionaryRepresentation] forKey:kINSDataComments];
    [mutableDict setValue:[self.caption dictionaryRepresentation] forKey:kINSDataCaption];
    NSMutableArray *tempArrayForUsersInPhoto = [NSMutableArray array];
    for (NSObject *subArrayObject in self.usersInPhoto) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForUsersInPhoto addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForUsersInPhoto addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForUsersInPhoto] forKey:kINSDataUsersInPhoto];
    [mutableDict setValue:self.link forKey:kINSDataLink];
    [mutableDict setValue:[self.likes dictionaryRepresentation] forKey:kINSDataLikes];
    [mutableDict setValue:self.type forKey:kINSDataType];
    NSMutableArray *tempArrayForTags = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tags) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTags addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTags addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTags] forKey:kINSDataTags];
    [mutableDict setValue:[self.location dictionaryRepresentation] forKey:kINSDataLocation];
    [mutableDict setValue:self.filter forKey:kINSDataFilter];
    [mutableDict setValue:[self.images dictionaryRepresentation] forKey:kINSDataImages];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kINSDataUser];
    [mutableDict setValue:self.attribution forKey:kINSDataAttribution];

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

    self.dataIdentifier = [aDecoder decodeObjectForKey:kINSDataId];
    self.createdTime = [aDecoder decodeObjectForKey:kINSDataCreatedTime];
    self.comments = [aDecoder decodeObjectForKey:kINSDataComments];
    self.caption = [aDecoder decodeObjectForKey:kINSDataCaption];
    self.usersInPhoto = [aDecoder decodeObjectForKey:kINSDataUsersInPhoto];
    self.link = [aDecoder decodeObjectForKey:kINSDataLink];
    self.likes = [aDecoder decodeObjectForKey:kINSDataLikes];
    self.type = [aDecoder decodeObjectForKey:kINSDataType];
    self.tags = [aDecoder decodeObjectForKey:kINSDataTags];
    self.location = [aDecoder decodeObjectForKey:kINSDataLocation];
    self.filter = [aDecoder decodeObjectForKey:kINSDataFilter];
    self.images = [aDecoder decodeObjectForKey:kINSDataImages];
    self.user = [aDecoder decodeObjectForKey:kINSDataUser];
    self.attribution = [aDecoder decodeObjectForKey:kINSDataAttribution];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_dataIdentifier forKey:kINSDataId];
    [aCoder encodeObject:_createdTime forKey:kINSDataCreatedTime];
    [aCoder encodeObject:_comments forKey:kINSDataComments];
    [aCoder encodeObject:_caption forKey:kINSDataCaption];
    [aCoder encodeObject:_usersInPhoto forKey:kINSDataUsersInPhoto];
    [aCoder encodeObject:_link forKey:kINSDataLink];
    [aCoder encodeObject:_likes forKey:kINSDataLikes];
    [aCoder encodeObject:_type forKey:kINSDataType];
    [aCoder encodeObject:_tags forKey:kINSDataTags];
    [aCoder encodeObject:_location forKey:kINSDataLocation];
    [aCoder encodeObject:_filter forKey:kINSDataFilter];
    [aCoder encodeObject:_images forKey:kINSDataImages];
    [aCoder encodeObject:_user forKey:kINSDataUser];
    [aCoder encodeObject:_attribution forKey:kINSDataAttribution];
}

- (id)copyWithZone:(NSZone *)zone
{
    INSData *copy = [[INSData alloc] init];
    
    if (copy) {

        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.createdTime = [self.createdTime copyWithZone:zone];
        copy.comments = [self.comments copyWithZone:zone];
        copy.caption = [self.caption copyWithZone:zone];
        copy.usersInPhoto = [self.usersInPhoto copyWithZone:zone];
        copy.link = [self.link copyWithZone:zone];
        copy.likes = [self.likes copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.tags = [self.tags copyWithZone:zone];
        copy.location = [self.location copyWithZone:zone];
        copy.filter = [self.filter copyWithZone:zone];
        copy.images = [self.images copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
        copy.attribution = [self.attribution copyWithZone:zone];
    }
    
    return copy;
}


@end
