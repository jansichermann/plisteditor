//
//  main.m
//  versionnumber
//
//  Created by Jan Sichermann on 8/31/14.
//  Copyright (c) 2014 Jan Sichermann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlistInterface.h"

static NSString * const fileParameterKey = @"-f";
static NSString * const valueParameterKey = @"-v";
static NSString * const keyParameterKey = @"-k";

NS_RETURNS_RETAINED NSString *argumentForIndex(int index, const char *argv[]) {
    const char * arg = argv[index];
    return [NSString stringWithUTF8String:arg];
}

void printHelp() {
    NSString *helpString = @"\nPList Editor\n\nhttps://github.com/jansichermann/plisteditor\n\nUsage: \n\n";
    helpString = [helpString stringByAppendingString:@"Options: \n"];
    helpString = [helpString stringByAppendingFormat:@"%@\t\tfile path to .plist file\n", fileParameterKey];
    helpString = [helpString stringByAppendingFormat:@"%@\t\tnew value\n", valueParameterKey];
    helpString = [helpString stringByAppendingFormat:@"%@\t\tfor key\n", keyParameterKey];
    NSLog(@"%@", helpString);
}


int validateParameterIndex(int argc, int index) {
    return argc > index + 1 ? 0 : -1;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *filePath = nil;
        NSString *value = nil;
        NSString *key = nil;

        int i = 0;
        while (i < argc) {
            const char *c = argv[i];
            
            NSString *argument = [NSString stringWithUTF8String:c];
            if ([argument isEqualToString:@"-help"]) {
                printHelp();
                return 0;
            }
            
            
            if ([argument isEqualToString:fileParameterKey]) {
                if (validateParameterIndex(argc, i) != 0) {
                    return 1;
                }
                
                filePath = argumentForIndex(i+1, argv);
                i++;
                continue;
            }
            
            
            if ([argument isEqualToString:valueParameterKey]) {
                if (validateParameterIndex(argc, i) != 0) {
                    return 1;
                }
                
                value = argumentForIndex(i+1, argv);
                i++;
                continue;
            }
            
            
            if ([argument isEqualToString:keyParameterKey]) {
                if (validateParameterIndex(argc, i) != 0) {
                    return 1;
                }
                
                key = argumentForIndex(i+1, argv);
                i++;
                continue;
            }

            i++;
        }
        
        if (filePath && value && key) {
            [PlistInterface updateValue:value
                                 forKey:key
                     inDictionaryAtPath:filePath];
        }
        else {
            printHelp();
            return 1;
        }
    }
    return 0;
}
