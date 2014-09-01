#import "PlistInterface.h"

// CFBundleShortVersionString - public
// CFBundleVersion - internal

@implementation PlistInterface

+ (void)updateValue:(NSObject *)value
             forKey:(NSObject <NSCopying>*)key
 inDictionaryAtPath:(NSString *)filePath {
    
    NSParameterAssert(value);
    NSParameterAssert(key);
    NSParameterAssert(filePath.length > 0);
    
    NSLog(@"%@:\t\t%@ -> %@", filePath, key, value);
    
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
    d[key] = value;
    [d writeToFile:filePath
        atomically:YES];
}

@end
