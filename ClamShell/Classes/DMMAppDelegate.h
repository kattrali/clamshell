//
//  DMMAppDelegate.h
//  ClamShell
//
//  Created by Delisa Mason on 1/23/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//
#import "DMMWindowController.h"

@interface DMMAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet DMMWindowController *mainController;
@property (weak) IBOutlet DMMPopover *popover;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)closePopoverHandler:(id)sender;

- (NSURL *) applicationFilesDirectory;
@end
