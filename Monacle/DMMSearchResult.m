//
//  DMMSearchResult.m
//  Monacle
//
//  Created by Delisa Mason on 1/24/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import "DMMSearchResult.h"
@interface DMMSearchResult ()

@property (nonatomic, strong) NSString *delimiter;
@property (nonatomic, strong) NSString *htmlFileName;

@end

@implementation DMMSearchResult

- (id) initWithName: (NSString *) name path: (NSString *) path type: (NSString *) type
{
  self = [super init];
  if (self) {
    self.name = name;
    self.path = path;
    self.type = type;
    [self parseDelimiter];
    [self parseHTMLFileName];
  }
  return self;
}

- (void) parseHTMLFileName
{
  NSRegularExpression *exp = [NSRegularExpression regularExpressionWithPattern:@"\\/([A-Za-z0-9]+)\\.html" options:NSRegularExpressionDotMatchesLineSeparators error:nil];

  NSArray *matches = [exp matchesInString:self.path
                                  options:0
                                    range:NSMakeRange(0, [self.path length])];

  if (matches.count > 0) {
    NSTextCheckingResult *match = matches[0];
    NSRange matchRange = [match rangeAtIndex:1];

    self.htmlFileName = [self.path substringWithRange:matchRange];
  }
}

- (void) parseDelimiter
{
  if ([self.path rangeOfString:@"class_method"].location != NSNotFound) {
    self.delimiter = @"+";
  } else if ([self.path rangeOfString:@"instance_method"].location != NSNotFound) {
    self.delimiter = @"-";
  } else if ([self.type isEqualToString:@"clconst"]) {
    self.delimiter = @"::";
  }
}

- (NSString *) displayText
{
  return [NSString stringWithFormat:@"%@ (%@)", self.name, self.htmlFileName];
}

- (NSString *) signature
{
  if ([self.type isEqualToString:@"clm"] ||[self.type isEqualToString:@"clconst"]) {
    return [NSString stringWithFormat:@"%@%@%@", self.htmlFileName, self.delimiter, self.name];
  }
  return self.name;
}
@end
