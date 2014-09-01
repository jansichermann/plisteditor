//
//  PlistInterface.h
//  versionnumber
//
//  Created by Jan Sichermann on 8/31/14.
//  Copyright (c) 2014 Jan Sichermann. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlistInterface : NSObject

+ (void)updateValue:(NSObject *)value
             forKey:(NSObject <NSCopying>*)key
 inDictionaryAtPath:(NSString *)filePath;

@end
