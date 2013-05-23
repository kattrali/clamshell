//
//  DMMTokenStore.h
//  ClamShell
//
//  Created by Delisa Mason on 1/24/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMMTokenStore : NSObject

+ (NSArray *) tokensWithText:(NSString *) text;
+ (BOOL) hasDataStoreFile;
+ (NSString *) databasePath;
+ (NSURL *) docSetDirectory;
@end
