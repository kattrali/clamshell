//
//  DMMTokenStore.m
//  ClamShell
//
//  Created by Delisa Mason on 1/24/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import "DMMTokenStore.h"
#import "DMMAppDelegate.h"
#import "FMDatabase.h"

@implementation DMMTokenStore

+ (NSString *) databasePath
{
  NSString *dir = [[((DMMAppDelegate *)[[NSApplication sharedApplication] delegate]) docSetDirectory] path];
  return [dir stringByAppendingPathComponent:@"Contents/Resources/docSet.dsidx"];
}

+ (BOOL) hasDataStoreFile
{
  return [[NSFileManager defaultManager] fileExistsAtPath:[self databasePath]];
}

+ (NSArray *) tokensWithText:(NSString *) text {
  NSMutableArray *results = [NSMutableArray arrayWithCapacity:20];

  if (![self hasDataStoreFile]) return results;

  FMDatabase *db = [FMDatabase databaseWithPath:[self databasePath]];
  db.logsErrors = YES;
//  db.traceExecution = YES;
  if ([db open]) {
    NSString *query = @"SELECT name,type,path FROM searchIndex WHERE name LIKE :text ORDER BY name LIMIT :max COLLATE NOCASE";
    NSDictionary *params = @{@"text" : [NSString stringWithFormat:@"%@%%", text], @"max" : @20 };
    
    FMResultSet *rows = [db executeQuery:query withParameterDictionary:params];
    while ([rows next]) {
      NSString *name = [rows stringForColumn:@"name"];
      NSString *type = [rows stringForColumn:@"type"];
      NSString *api  = [rows stringForColumn:@"path"];

      [results addObject:[[DMMSearchResult alloc] initWithName:name path:api type:type]];
    }
    [db close];
  }
  return results;
}

@end
