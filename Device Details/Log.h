//
//  Log.h
//  Device Details
//
//  Created by Jingxi & Yi on 19/03/2014.
//  Copyright (c) 2014 Robert Yi Jiang. All rights reserved.
//

@interface Log : NSObject
void _Log(NSString *format, const char *file, int lineNumber, const char *funcName, NSString *format,...);
@end