//
//  DMMSampleSpec.m
//  ClamShell
//
//  Created by Delisa Mason on 4/2/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import "Kiwi.h"
#import "DMMSearchResult.h"

SPEC_BEGIN(DMMSearchResultSpec)

describe(@"Initialization", ^{
  NSString *fileName = @"SomeClass";
  __block DMMSearchResult *result = nil;

  beforeAll(^{
    result   = [[DMMSearchResult alloc] initWithName:@"someMethod" path:[NSString stringWithFormat:@"Packages/Package/%@.html", fileName] type:@"clm"];
  });

  it(@"fetches a parent name", ^{
    [[[result htmlFileName] should] equal:fileName];
  });

  it(@"should have an icon", ^{
    [[result icon] shouldNotBeNil];
  });

  it(@"should have a type", ^{
    [[result type] shouldNotBeNil];
  });
});

SPEC_END