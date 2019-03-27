//
//  ViewController.h
//  CommonTools
//
//  Created by kuyuzhiqi on 2018/6/20.
//  Copyright © 2018 kuyuzhiqi. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
@property (strong) IBOutlet NSTextField *curtTimeTextField;
@property (strong) IBOutlet NSTextField *unixTimestamp;
@property (strong) IBOutlet NSTextField *utc8Timestamp;
@property (strong) IBOutlet NSPopUpButton *timeTypePopButton;
@property (strong) IBOutlet NSPopUpButton *timeTypePopButton2;
@property (strong) IBOutlet NSTextField *utc8ResultTextField;
@property (strong) IBOutlet NSTextField *unixResultTextField;
@property(nonatomic) Boolean isSecond;
@property(nonatomic) Boolean isSecond2;
@property(weak)NSTimer *timer;

@property (strong) IBOutlet NSTextField *widthTextField;
@property (strong) IBOutlet NSTextField *heightTextField;
@property (strong) IBOutlet NSTextField *ppiResultTextField;
@property (strong) IBOutlet NSTextField *screenSizeTextField;

- (IBAction)refreshTimeRepeat:(id)sender;
- (IBAction)refresh:(id)sender;
- (IBAction)changeToUTC8:(id)sender;
- (IBAction)changeToUnixTimestamp:(id)sender;
- (IBAction)stopRefresh:(id)sender;

@end

