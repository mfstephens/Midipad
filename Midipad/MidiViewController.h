//
//  MidiViewController.h
//  Midipad
//
//  Created by Matthew Stephens on 7/18/14.
//  Copyright (c) 2014 Matthew Stephens. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MidiViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *menuDrawer;
}

@property (readonly, nonatomic) NSArray* soundFiles;
@property (readonly, nonatomic) BOOL setNewSound;
@property (nonatomic) NSMutableDictionary* currentButtonMapping;
@property (readonly, nonatomic) int currentLibIndex;
@property (readonly, nonatomic) UISwipeGestureRecognizer *recognizer_open, *recognizer_close;
@property (readonly, nonatomic) int menuDrawerX, menuDrawerWidth;


- (void)initSoundFiles;
- (void)initButtons;
- (void)handleSwipes:(UISwipeGestureRecognizer *) sender;
- (void)drawerAnimaton;

- (void)playSound: (NSString*)URL;

@end
