//
//  ParserUtils.h
//
//
//  Created by Andrey Andreev on 8/17/10.
//  Copyright 2011 Abyrvalg. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ParserUtils : NSObject {

}

+(id) object:(NSDictionary *)dictionary key:(NSString *)key;
+(NSDictionary *) map:(NSDictionary *)dictionary key:(NSString *)key;
+(NSArray *) array:(NSDictionary *)dictionary key:(NSString *)key;
+(NSString *) stringValue:(NSDictionary *)dictionary key:(NSString *)key;

+(NSNumber *) numberValue:(NSDictionary *)dictionary key:(NSString *)key;
+(NSNumber *) forceNumber:(NSDictionary *)json key:(NSString *)key;
    
+(NSDate *) dateValue:(id) json key:(NSString *)key;
+(NSInteger) intValue:(NSDictionary *)dictionary key:(NSString *)key;
+(NSInteger) intValue:(NSDictionary *)dictionary key:(NSString *)key defaultValue:(int)value;
+(float) floatValue:(NSDictionary *)dictionary key:(NSString *)key;
+(BOOL) boolValue:(id)value;
+(BOOL) boolValue:(NSDictionary *)dictionary key:(NSString *)key;
+(BOOL) boolValue:(NSDictionary *)dictionary key:(NSString *)key defaultValue:(BOOL)defaultValue;

+(void) encodeDate:(NSDate *)date withCoder:(NSCoder *)coder forKey:(NSString *)key;
+(NSDate *)decodeDateWithCoder:(NSCoder *)coder forKey:(NSString *)key;

@end
