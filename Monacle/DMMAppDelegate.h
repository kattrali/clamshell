//
//  DMMAppDelegate.h
//  Monacle
//
//  Created by Delisa Mason on 1/23/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//
#import "DMMWindowController.h"

@interface DMMAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (NSURL *) docSetDirectory;

@property (weak) IBOutlet WebView *webView;
@property (weak) IBOutlet NSOutlineView *outlineView;
@property (weak) IBOutlet NSSearchField *searchField;
@property (strong, nonatomic) DMMWindowController *mainController;
@end
