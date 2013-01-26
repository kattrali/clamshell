//
//  DMMAppDelegate.m
//  ClamShell
//
//  Created by Delisa Mason on 1/23/13.
//  Copyright (c) 2013 Delisa Mason. All rights reserved.
//

#import "DMMAppDelegate.h"
#import "DMMWindowController.h"
#import "DMMURLParser.h"

#define DOCSET_DIR @"DocSet"

@interface DMMAppDelegate()

- (void)handleGetURLEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent;

@end

@implementation DMMAppDelegate

-(void)applicationWillFinishLaunching:(NSNotification *)aNotification
{
  NSAppleEventManager *appleEventManager = [NSAppleEventManager sharedAppleEventManager];
  [appleEventManager setEventHandler:self
                         andSelector:@selector(handleGetURLEvent:withReplyEvent:)
                       forEventClass:kInternetEventClass andEventID:kAEGetURL];
}

- (IBAction)openDocument:(id)sender
{
  NSOpenPanel* openDlg = [NSOpenPanel openPanel];

  [openDlg setCanChooseFiles:YES];
  [openDlg setAllowsMultipleSelection:NO];
  [openDlg setCanChooseDirectories:NO];
  
  if ([openDlg runModal] == NSOKButton)
  {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *fileURL = [openDlg URL];
    NSURL *target  = [self docSetDirectory];

    NSError *error;
    if ([manager fileExistsAtPath:[fileURL path]]) {
      if([manager fileExistsAtPath:[target path]]) {
        [manager removeItemAtPath:[target path] error:nil];
      }

      [manager copyItemAtURL:fileURL toURL:target error:&error];
      if (error) {
        NSLog(@"Could not copy (%@): %@",[fileURL path], [error localizedDescription]);
      }
    }
  }
}

- (NSURL *) docSetDirectory
{
  return [[self applicationFilesDirectory] URLByAppendingPathComponent:DOCSET_DIR];
}

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "ClamShell" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[manager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    
    NSURL *dir = [appSupportURL URLByAppendingPathComponent:@"ClamShell"];
    if(![manager fileExistsAtPath:[dir path]]) {
      [manager createDirectoryAtPath:[dir path] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dir;
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication
                    hasVisibleWindows:(BOOL)flag
{
  if (!flag) {
    [self.window orderFront:self];
  }
  return YES;
}

- (void)handleGetURLEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent
{
  NSURL *url = [NSURL URLWithString:[[event paramDescriptorForKeyword:keyDirectObject] stringValue]];
  DMMURLParser *parser = [[DMMURLParser alloc] initWithURL:url];
  NSString *searchText = [parser valueForVariable:@"searchText"];
  NSString *xValue = [parser valueForVariable:@"x"];
  NSString *yValue = [parser valueForVariable:@"y"];
  if (xValue && yValue) {
    if ([self.window isVisible]) [self.window orderOut:self];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    CGFloat x = [[formatter numberFromString:xValue] floatValue];
    CGFloat y = [[formatter numberFromString:yValue] floatValue];
    [self.mainController displayFirstResultFor:searchText atPoint:CGPointMake(x, y)];
  } else {
    if (![self.window isVisible]) [self.window orderFront:self];
    [self.mainController searchFor:searchText loadFirst:YES];
  }
}

- (IBAction)closePopoverHandler:(id)sender {
  [self.popover close];
  [[NSApplication sharedApplication] hide:self];
}
@end
