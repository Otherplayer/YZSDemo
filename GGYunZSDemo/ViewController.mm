//
//  ViewController.m
//  GGYunZSDemo
//
//  Created by __无邪_ on 16/6/23.
//  Copyright © 2016年 __无邪_. All rights reserved.
//
#import "ViewController.h"
#import "Configure.h"
#import "USCSpeechUnderstander.h"
#import "USCSpeechResult.h"


@interface ViewController ()<USCSpeechUnderstanderDelegate>

@property (nonatomic,strong) USCSpeechUnderstander *speechUnderstander;
@property (nonatomic,strong) NSMutableString  *asrString;
@property (weak, nonatomic) IBOutlet UIButton *btnStart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.asrString = [[NSMutableString alloc]init];
    // 创建对象
    USCSpeechUnderstander *speechUnderstander = [[USCSpeechUnderstander alloc]initWithContext:nil appKey:APPKEY secret:SECRET];
    self.speechUnderstander = speechUnderstander;
    self.speechUnderstander.delegate = self;
    
//    [self.speechUnderstander setVadFrontTimeout:3000 backTime:1000];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAction:(id)sender {
    //general
    //16000
    [self.speechUnderstander setEngine:@"general"];
    [self.speechUnderstander setBandwidth:16000];
    [self.speechUnderstander start];
    
}
#pragma mark -  SpeechUnderstanderDelegate

- (void)onRecognizerResult:(NSString *)result isLast:(BOOL)isLast
{
    NSLog(@"一次返回结果");
    if (result)
        [self.asrString appendString:result];
    
    if(isLast)
    {
        NSLog(@"最后一次返回结果");
    }
}

- (void)onUnderstanderResult:(USCSpeechResult *)result
{
    NSLog(@"返回的语义理解结果 = %@",result.stringResult);
}

- (void)onSpeechStart
{
    NSLog(@"状态:开始说话");
}

- (void)onRecognizerStart
{
    NSLog(@"识别开始");
}

- (void)onRecordingStop:(NSData *)data
{
}

- (void)onRecordingStart
{
    NSLog(@"录音开始");
}

- (void)onVADTimeout
{
    NSLog(@"vad timeout");
}

- (void)onUpdateVolume:(int)volume
{
//    self.statusLabel.text = @"状态:正在录音...";
//    float volumeRate = volume / 100.0f;
//    
//    [self.progressView setProgress:volumeRate animated:YES];
}

- (void)onEnd:(NSError *)error
{
    if(error)
    {
        NSLog(@"出错了");
        return;
    }
    else if (self.asrString.length == 0 )
    {
        NSLog(@"没有听到声音");
    }
    NSLog(@"done");
}

@end
