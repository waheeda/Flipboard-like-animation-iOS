//
//  ParserUtils.m
//
//
//  Created by Andrey Andreev on 8/17/10.
//

#import "ParserUtils.h"

@implementation ParserUtils

+ (id)object:(NSDictionary *)dictionary key:(NSString *)key {
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id obj = [dictionary objectForKey:key];
    if ([obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return obj;
}

+ (NSDictionary *)map:(NSDictionary *)dictionary key:(NSString *)key {
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id obj = [ParserUtils object:dictionary key:key];
    if (!obj || ![obj isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return obj;
}

+ (NSArray *)array:(NSDictionary *)dictionary key:(NSString *)key {
    id obj = [ParserUtils object:dictionary key:key];
    if (!obj || ![obj isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return obj;
}

+ (NSString *)stringValue:(NSDictionary *)dictionary key:(NSString *)key {
    id obj = [ParserUtils object:dictionary key:key];
    if (!obj || ![obj isKindOfClass:[NSString class]]) {
        return nil;
    }
    return obj;
}

+ (NSNumber *)numberValue:(NSDictionary *)dictionary key:(NSString *)key {
    id obj = [ParserUtils object:dictionary key:key];
    if (!obj || ![obj isKindOfClass:[NSNumber class]]) {
        return nil;
    }
    return obj;
}

+ (NSInteger)intValue:(NSDictionary *)dictionary key:(NSString *)key {
    id obj = [ParserUtils numberValue:dictionary key:key];
    return [obj integerValue];
}

+ (NSInteger)intValue:(NSDictionary *)dictionary key:(NSString *)key defaultValue:(int)value {
    id obj = [ParserUtils numberValue:dictionary key:key];
    return obj ? [obj integerValue] : value;
}


+ (float)floatValue:(NSDictionary *)dictionary key:(NSString *)key {
    id obj = [ParserUtils numberValue:dictionary key:key];
    return [obj floatValue];
}


+ (BOOL)boolValue:(id)value defaultValue:(BOOL)defaultValue {

    if (!value) {
        return defaultValue;
    }

    if ([value isKindOfClass:[NSNumber class]]) {
        return [value boolValue];
    }

    if ([value isKindOfClass:[NSNull class]]) {
        return defaultValue;
    }

    if ([value isKindOfClass:[NSString class]]) {
        value = [value lowercaseString];
        //if([value isEqualToString:@"null"]) return NO;
        if ([value isEqualToString:@"false"]) return NO;
        if ([value isEqualToString:@"no"]) return NO;
        if ([value isEqualToString:@"yes"]) return YES;
        if ([value isEqualToString:@"true"]) return YES;
    }

    return defaultValue;
}

+ (BOOL)boolValue:(id)value {
    return [ParserUtils boolValue:value defaultValue:NO];
}

+ (BOOL)boolValue:(NSDictionary *)dictionary key:(NSString *)key {
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    id obj = [dictionary objectForKey:key];
    return [ParserUtils boolValue:obj];
}

+ (BOOL)boolValue:(NSDictionary *)dictionary key:(NSString *)key defaultValue:(BOOL)defaultValue {
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return defaultValue;
    }
    id obj = [dictionary objectForKey:key];
    return [ParserUtils boolValue:obj defaultValue:defaultValue];
}


+ (void)encodeDate:(NSDate *)date withCoder:(NSCoder *)coder forKey:(NSString *)key {
    if (!date) {
        return;
    }
    NSNumber *value = [NSNumber numberWithDouble:[date timeIntervalSince1970]];
    [coder encodeObject:value forKey:key];
}

+ (NSDate *)decodeDateWithCoder:(NSCoder *)coder forKey:(NSString *)key {
    NSNumber *value = [coder decodeObjectForKey:key];
    if (!value) {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
}

+ (NSDate *)dateValue:(id)json key:(NSString *)key {
    NSNumber *value = [ParserUtils numberValue:json key:key];
    if (!value) {
        return nil;
    }
    return nil;
//	return [NSDate dateWithTimeIntervalSince1970:[value doubleValue]];
    //return [NSDate dateWithHammerTime:value.hammerTime];
}

+ (NSUInteger)hexValue:(NSString *)hex {
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    unsigned int result = 0;
    [scanner scanHexInt:&result];
    return result;
}

+ (NSNumber *)forceNumber:(NSDictionary *)json key:(NSString *)key {
    NSNumber *number = [ParserUtils numberValue:json key:key];
    if (number) {
        return number;
    }
    NSString *value = [ParserUtils stringValue:json key:key];
    if (value) {
        long long scannedNumber;
        NSScanner *scanner = [NSScanner scannerWithString:value];
        [scanner scanLongLong:&scannedNumber];
        return [NSNumber numberWithLongLong:scannedNumber];
    }
    return nil;
}

//+(NSString *)removeHTML:(NSString *)str {
//    str = [str stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
//    str = [str stringByReplacingOccurrencesOfString:@"</br>" withString:@"\n"];
//    str = [str gtm_stringByUnescapingFromHTML];
//    return str;
//}




@end
