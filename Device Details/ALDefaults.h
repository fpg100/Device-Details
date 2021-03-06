/*
     File: ALDefaults.h
 Abstract: Contains default values for the application.
 
  Version: 1.0

 */

#import <Foundation/Foundation.h>

@interface ALDefaults : NSObject

+ (ALDefaults *)sharedDefaults;

@property (nonatomic, copy, readonly) NSArray *supportedProximityUUIDs;

@property (nonatomic, copy, readonly) NSUUID *defaultProximityUUID;
@property (nonatomic, copy, readonly) NSNumber *defaultPower;

@end
