//
//  MidiViewController.m
//  Midipad
//
//  Created by Matthew Stephens on 7/18/14.
//  Copyright (c) 2014 Matthew Stephens. All rights reserved.
//

#import "MidiViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface MidiViewController ()


@end

@implementation MidiViewController

const NSArray *soundFiles = nil;

- (void) initSoundFiles
{
    soundFiles = [NSArray arrayWithObjects:
                  @"syn_clap20",
                  @"syn_hh05",
                  @"syn_kick05",
                  @"syn_perc05",
                  @"syn_sd03",
                  @"syn_shaker03",
                  @"syn_clap01",
                  @"syn_cowbell01",
                  @"syn_hh06",
                  @"syn_kick06",
                  @"syn_perc06",
                  @"syn_sd04",
                  @"syn_shaker04",
                  @"syn_clap02",
                  @"syn_cowbell02",
                  @"syn_hh07",
                  @"syn_kick07",
                  @"syn_perc07",
                  @"syn_sd05",
                  @"syn_shaker05",
                  @"syn_clap03",
                  @"syn_cowbell03",
                  @"syn_hh08",
                  @"syn_kick08",
                  @"syn_ride01",
                  @"syn_sd06",
                  @"syn_shaker06",
                  @"syn_clap04",
                  @"syn_fx01",
                  @"syn_hh09",
                  @"syn_kick09",
                  @"syn_ride02",
                  @"syn_sd07",
                  @"syn_shaker07",
                  @"syn_clap05",
                  @"syn_fx02",
                  @"syn_hh10",
                  @"syn_kick10",
                  @"syn_ride03",
                  @"syn_sd08",
                  @"syn_shaker08",
                  @"syn_clap06",
                  @"syn_fx03",
                  @"syn_hh11",
                  @"syn_kick11",
                  @"syn_ride04",
                  @"syn_sd09",
                  @"syn_tom01",
                  @"syn_clap07",
                  @"syn_fx04",
                  @"syn_hh12",
                  @"syn_kick12",
                  @"syn_ride05",
                  @"syn_sd10",
                  @"syn_tom02",
                  @"syn_clap08",
                  @"syn_fx05",
                  @"syn_hh13",
                  @"syn_kick13",
                  @"syn_ride06",
                  @"syn_sd11",
                  @"syn_tom03",
                  @"syn_clap09",
                  @"syn_fx06",
                  @"syn_hh14",
                  @"syn_kick14",
                  @"syn_ride07",
                  @"syn_sd12",
                  @"syn_tom04",
                  @"syn_clap10",
                  @"syn_fx07",
                  @"syn_hh15",
                  @"syn_kick15",
                  @"syn_ride08",
                  @"syn_sd13",
                  @"syn_tom05",
                  @"syn_clap11",
                  @"syn_fx08",
                  @"syn_hh16",
                  @"syn_kick16",
                  @"syn_rim01",
                  @"syn_sd14",
                  @"syn_tom06",
                  @"syn_clap12",
                  @"syn_fx09",
                  @"syn_hh17",
                  @"syn_kick17",
                  @"syn_rim02",
                  @"syn_sd15",
                  @"syn_tom07",
                  @"syn_clap13",
                  @"syn_fx10",
                  @"syn_hh18",
                  @"syn_kick18",
                  @"syn_rim03",
                  @"syn_sd16",
                  @"syn_tom08",
                  @"syn_clap14",
                  @"syn_fx11",
                  @"syn_hh19",
                  @"syn_kick19",
                  @"syn_rim04",
                  @"syn_sd17",
                  @"syn_zap01",
                  @"syn_clap15",
                  @"syn_fx12",
                  @"syn_hh20",
                  @"syn_kick20",
                  @"syn_rim05",
                  @"syn_sd18",
                  @"syn_zap02",
                  @"syn_clap16",
                  @"syn_hh01",
                  @"syn_kick01",
                  @"syn_perc01",
                  @"syn_rim06",
                  @"syn_sd19",
                  @"syn_zap03",
                  @"syn_clap17",
                  @"syn_hh02",
                  @"syn_kick02",
                  @"syn_perc02",
                  @"syn_rim07",
                  @"syn_sd20",
                  @"syn_zap04",
                  @"syn_clap18",
                  @"syn_hh03",
                  @"syn_kick03",
                  @"syn_perc03",
                  @"syn_sd01",
                  @"syn_shaker01",
                  @"syn_zap05",
                  @"syn_clap19",
                  @"syn_hh04",
                  @"syn_kick04",
                  @"syn_perc04",
                  @"syn_sd02",
                  @"syn_shaker02", nil];
}

- (void)initButtons
{
    _currentButtonMapping = [[NSMutableDictionary alloc] init];
    [_currentButtonMapping setObject:@"syn_clap20" forKey:@"greenButton"];
    [_currentButtonMapping setObject:@"syn_hh05" forKey:@"darkBlueButton"];
    [_currentButtonMapping setObject:@"syn_kick05" forKey:@"grayButton"];
    [_currentButtonMapping setObject:@"syn_perc05" forKey:@"yellowButton"];
    [_currentButtonMapping setObject:@"syn_sd03" forKey:@"peachButton"];
    [_currentButtonMapping setObject:@"syn_shaker03" forKey:@"lightBlueButton"];
    [_currentButtonMapping setObject:@"syn_clap01" forKey:@"blackButton"];
    [_currentButtonMapping setObject:@"syn_cowbell01" forKey:@"purpleButton"];
}

- (void)playSound: (NSString*)URL {
    NSString *path  = [[NSBundle mainBundle] pathForResource:URL ofType:@"wav"];
    NSURL *pathURL = [NSURL fileURLWithPath : path];
    
    SystemSoundID audioEffect;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef) pathURL, &audioEffect);
    AudioServicesPlaySystemSound(audioEffect);
}


- (IBAction)pressedPadButton:(id)sender {
    if (_setNewSound) {
        [_currentButtonMapping setObject:[soundFiles objectAtIndex:_currentLibIndex] forKey: [sender currentTitle]];
        _setNewSound = false;
    }
    [self playSound:[_currentButtonMapping objectForKey:[sender currentTitle]]];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initSoundFiles];
    [self initButtons];
}

- (void)viewDidLoad{
    _menuDrawerWidth = self.view.frame.size.width * 0.75;
    _menuDrawerX = self.view.frame.origin.x;
    menuDrawer = [[UITableView alloc] initWithFrame:CGRectMake(_menuDrawerX, self.view.frame.origin.y, _menuDrawerWidth, self.view.frame.size.height)];
    
    menuDrawer.backgroundColor = [UIColor whiteColor];
    
    _recognizer_close = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    _recognizer_open = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipes:)];
    
    _recognizer_close.direction = UISwipeGestureRecognizerDirectionLeft;
    _recognizer_open.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:_recognizer_close];
    [self.view addGestureRecognizer:_recognizer_open];
    
    menuDrawer.delegate = self;
    menuDrawer.dataSource = self;
    
    [self.view addSubview:menuDrawer];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 137;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    
    cell.textLabel.text = [soundFiles objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _currentLibIndex = (int)[indexPath row];
    _setNewSound = true;
    [self drawerAnimaton];
}

- (void)handleSwipes:(UISwipeGestureRecognizer *) sender {
    [self drawerAnimaton];
}

- (void)drawerAnimaton {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:-5];
    
    CGFloat new_x = 0;
    if (menuDrawer.frame.origin.x < self.view.frame.origin.x) {
        new_x = menuDrawer.frame.origin.x + _menuDrawerWidth;
    }
    else {
        new_x = menuDrawer.frame.origin.x - _menuDrawerWidth;
    }
    
    menuDrawer.frame = CGRectMake(new_x, menuDrawer.frame.origin.y, menuDrawer.frame.size.width, menuDrawer.frame.size.height);
    
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
