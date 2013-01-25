//
//  DMMSearchResult.h
//  ClamShell
//
//  Created by Delisa Mason on 1/24/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DMMSearchResult : NSObject

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *htmlFileName;
@property (nonatomic, strong) NSImage *icon;

- (id) initWithName: (NSString *) name path: (NSString *) path type: (NSString *) type;
@end
