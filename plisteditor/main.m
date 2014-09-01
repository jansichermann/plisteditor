//    The MIT License (MIT)
//
//    Copyright (c) 2014 Jan Sichermann
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.




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
