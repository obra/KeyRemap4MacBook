// -*- Mode: objc; Coding: utf-8; indent-tabs-mode: nil; -*-
#import <Cocoa/Cocoa.h>

@interface KeyCode : NSObject {
  NSMutableDictionary* dict_;
}

// for debug
- (NSDictionary*) dictionary;

- (unsigned int) unsignedIntValue:(NSString*)name;
- (NSNumber*) numberValue:(NSString*)name;
- (BOOL) isExists:(NSString*)name;

- (void) append:(NSString*)name newvalue:(unsigned int)newvalue;
- (void) append:(NSString*)type name:(NSString*)name;

+ (NSString*) normalizeName:(NSString*)name;

@end
