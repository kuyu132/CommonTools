//
//  ViewController.m
//  CommonTools
//
//  Created by kuyuzhiqi on 2018/6/20.
//  Copyright © 2018 kuyuzhiqi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSTimeInterval curTime               = [[NSDate date] timeIntervalSince1970] * 1000;
    NSLog(@"%0.f", curTime);
    self.curtTimeTextField.stringValue =[NSString stringWithFormat:@"%0.f", curTime];
    // Do any additional setup after loading the view.

    [self.timeTypePopButton setAction:@selector(handlePopBtn:)];
     [self.timeTypePopButton2 setAction:@selector(handlePopBtn2:)];
    
    self.isSecond = NO;
    self.isSecond2 = NO;
    
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(widthTextFieldChange) name:NSControlTextDidChangeNotification object:self.widthTextField];
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(widthTextFieldChange) name:NSControlTextDidChangeNotification object:self.heightTextField];
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(widthTextFieldChange) name:NSControlTextDidChangeNotification object:self.screenSizeTextField];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)refresh:(id)sender {
    NSTimeInterval curTime               = [[NSDate date] timeIntervalSince1970] * 1000;
    NSLog(@"%0.f", curTime);
    self.curtTimeTextField.stringValue =[NSString stringWithFormat:@"%0.f", curTime];
}

- (IBAction)changeToUTC8:(id)sender {
    NSString *unixTimestampStr           = self.unixTimestamp.stringValue;

    NSLog(@"时间转换前：%@", unixTimestampStr);
    //装换为时间戳
    NSTimeInterval time=[unixTimestampStr doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    if(self.isSecond) {
    time                                 = time*1000;
    }
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter       = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr             = [dateFormatter stringFromDate: detailDate];

    NSLog(@"时间转换后：%@", currentDateStr);
    self.utc8ResultTextField.stringValue = currentDateStr;
}
- (IBAction)changeToUnixTimestamp:(id)sender {
    NSString *timestampStr               = self.utc8Timestamp.stringValue;
    NSDateFormatter *dateFormatter       = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate                     = [dateFormatter dateFromString:timestampStr];
    //字符串转成时间戳,精确到毫秒
    NSTimeInterval tmpTime =[tempDate timeIntervalSince1970] * 1000;
    if(self.isSecond2) {
    tmpTime                              = tmpTime/1000;
    }
    NSString *timeStr                    = [NSString stringWithFormat:@"%ld", (long)tmpTime];
    self.unixResultTextField.stringValue = timeStr;
}

- (void) refreshTime {
    NSTimeInterval curTime               = [[NSDate date] timeIntervalSince1970] * 1000;
    NSLog(@"%0.f", curTime);
    self.curtTimeTextField.stringValue =[NSString stringWithFormat:@"%0.f", curTime];
}

- (void)handlePopBtn:(NSPopUpButton*)popBtn{
    NSString *title                      = popBtn.selectedItem.title;
    if([title isEqualToString:@"毫秒"]) {
    self.isSecond                        = NO;
        NSLog(@"否");
    }else {
    self.isSecond                        = YES;
        NSLog(@"是");
    }
}

- (void)handlePopBtn2:(NSPopUpButton*)popBtn{
    NSString *title                      = popBtn.selectedItem.title;
    if([title isEqualToString:@"毫秒"]) {
    self.isSecond2                       = NO;
    }else {
    self.isSecond2                       = YES;
    }
}

- (IBAction)refreshTimeRepeat:(id)sender {
    if(self.timer == nil) {
    self.timer                           = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
    }
}
- (IBAction)stopRefresh:(id)sender {
    if(self.timer != nil) {
        [self.timer invalidate];
    }
}

- (void)widthTextFieldChange{
    int width = [self.widthTextField.stringValue intValue];
    int height = [self.heightTextField.stringValue intValue];
    double tmp = sqrt((double)(width * width + height * height));
    int size = [self.screenSizeTextField.stringValue intValue];
    if(size < 0 || size ==0) {
        return;
    }
    int result = (int)tmp /size;
    self.ppiResultTextField.stringValue = [NSString stringWithFormat:@"%d",result];
}
@end
