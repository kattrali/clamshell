//
//  DMMURLParserSpec.m
//  ClamShell
//
//  Created by Delisa Mason on 4/2/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import "Kiwi.h"
#import "DMMURLParser.h"

SPEC_BEGIN(DMMURLParserSpec)

describe(@"Parsing parameters", ^{ 
  NSString *colorKey   = @"color";
  NSString *colorValue = @"green";
  NSString *locKey     = @"location";
  NSString *locValue   = @"home";

  __block DMMURLParser *parser = nil;
  __block NSURL *url           = nil;

  it(@"should find variable values from a File URL", ^{
    url    = [NSURL URLWithString:[NSString stringWithFormat:@"file:///Users/username/Package/test.html?%@=%@&%@=%@", colorKey, colorValue, locKey, locValue]];
    parser = [[DMMURLParser alloc] initWithURL:url];
    [[[parser valueForVariable:colorKey] should] equal:colorValue];
    [[[parser valueForVariable:locKey] should] equal:locValue];
  });

  it(@"should find variable values from a params-only URL", ^{
    url    = [NSURL URLWithString:[NSString stringWithFormat:@"clamshell://%@=%@&%@=%@", colorKey, colorValue, locKey, locValue]];
    parser = [[DMMURLParser alloc] initWithURL:url];
    [[[parser valueForVariable:colorKey] should] equal:colorValue];
    [[[parser valueForVariable:locKey] should] equal:locValue];
  });
});
SPEC_END