//
//  Log.m
//  Device Details
//
//  Created by Jingxi & Yi on 19/03/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

#import "Log.h"
@implementation Log
void _Log(NSString *prefix, const char *file, int lineNumber, const char *funcName, NSString *format,...) {
    va_list ap;
    va_start (ap, format);
    format = [format stringByAppendingString:@"\n"];
    NSString *msg = [[NSString alloc] initWithFormat:[NSString stringWithFormat:@"%@",format] arguments:ap];
    va_end (ap);
    fprintf(stderr,"\n%s[%30s]:%4d -\t%s",[prefix UTF8String], [[[NSString stringWithUTF8String:file] lastPathComponent]UTF8String] , lineNumber, [msg UTF8String]);
    appendToFile(msg);
}


void appendToFile(NSString *msg){
    // get path to Documents/somefile.txt
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"logfile.txt"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]){ // create if needed
        fprintf(stderr,"Creating file at %s",[path UTF8String]);
        [[NSData data] writeToFile:path atomically:YES];
    }
    NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:path];// append
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    [handle writeData:[msg dataUsingEncoding:NSUTF8StringEncoding]];
    [handle closeFile];
}

-(NSString *) formatJsonData:(NSString *)rawMessageString{
    int jsonStartLocationInt    = 0;
    int jsonEndLocationInt      = 0;
    int jsonLengthInt           = 0;
    int jsonCounterInt          = 0;
    NSMutableString *cookedMessageMutableString;
    NSString *potentialJsonString;
//    BOOL hasJsonDataBool = NO;
//    int lengthInt = [rawMessageString length];
//    for (int i=0; i<lengthInt; ++i)
//    {
//        unichar character = [rawMessageString characterAtIndex:i];
//        if (character == '{'){
//            ++jsonCounterInt;
//        }else if (character == '}'){
//            --jsonCounterInt;
//        }
//       
//    }
    
    NSRange jsonStartrange = [rawMessageString rangeOfString:@"{"];
    NSRange jsonEndrange   = [rawMessageString rangeOfString:@"}" options:NSBackwardsSearch];
    if ( (jsonStartrange.location != NSNotFound) && (jsonEndrange.location != NSNotFound) )
        potentialJsonString = [rawMessageString substringWithRange:NSMakeRange(jsonStartrange.location, jsonEndrange.location-jsonStartrange.location)];
    
    NSData *potentialJsonData = [potentialJsonString dataUsingEncoding:NSUTF8StringEncoding];
                               
    NSString *jsonData = [NSJSONSerialization JSONObjectWithData:potentialJsonData
                                                  options:NSJSONReadingMutableContainers
                                                    error:nil];
    
    NSLog( @"%@", jsonData );
    
    return [cookedMessageMutableString copy];
}

@end
