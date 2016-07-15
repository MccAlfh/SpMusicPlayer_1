//
//  SLPlayingViewController.m
//  MusicPlayer
//
//  Created by Alfh on 16/6/4.
//  Copyright © 2016年 Alfh. All rights reserved.
//

#import "SLPlayingViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+Extension.h"
#import "AudioPlayTool.h"
#import "SLMusicTool.h"
#import "SLMusic.h"
@interface SLPlayingViewController ()

@property (strong, nonatomic)SLMusic *playingMusic;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;

@property (weak, nonatomic) IBOutlet UIButton *playOrPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;

@property (strong, nonatomic)AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;

- (IBAction)exitBtnClick:(id)sender;
- (IBAction)playOrPause:(id)sender;
- (IBAction)next:(id)sender;
- (IBAction)previous:(id)sender;


@end

@implementation SLPlayingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)show {
    if (self.playingMusic != [SLMusicTool playingMusic]) {
        [self resetPlayingMusic];
    }
//    1、拿到 window
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    2、设置当前控制器的 frame
    self.view.frame = window.bounds;
//    3、将当前控制器的 view 添加到 frame 上
    [window addSubview:self.view];
    self.view.hidden = NO;
//    4、执行动画，让控制器的 view 从底部钻出
    self.view.y = window.bounds.size.height;
//    [UIView animateWithDuration:1 animations:^{
//        self.view.y = 0;
//    }];
    
//    禁用交互功能
    window.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.y = 0;
    } completion:^(BOOL finished) {
//        开启交互
        window.userInteractionEnabled = YES;
//        SLMusic *music = [SLMusicTool playingMusic];
//        [AudioPlayTool playMusicWithFileName:music.filename];
        [self startPlayingMusic];
    }];
}

- (void)resetPlayingMusic {
    self.iconView.image = [UIImage imageNamed:@"play_cover_pic_bg"];
    self.songLabel.text = nil;
    self.singerLabel.text = nil;
    self.durationLabel.text = nil;
    [AudioPlayTool stopMusicWithFileName:self.playingMusic.filename];
}

- (void)startPlayingMusic {
    SLMusic *music = [SLMusicTool playingMusic];
    self.playingMusic = music;
    self.iconView.image = [UIImage imageNamed:music.icon];
    self.songLabel.text = music.name;
    self.singerLabel.text = music.singer;
    self.player = [AudioPlayTool playMusicWithFileName:music.filename];
    self.durationLabel.text = [self stringWithTimeInterval:self.player.duration];
}

- (NSString *)stringWithTimeInterval:(NSTimeInterval)timeInterval {
    int m = timeInterval / 60;
    int s = (int)timeInterval % 60;
    return [NSString stringWithFormat:@"%d:%d",m,s];
}
/**
 *  播放或者暂停
 *
 */
- (IBAction)playOrPause:(id)sender {
    if (self.playOrPauseButton == NO) {
        self.playOrPauseButton.selected = YES;
        [AudioPlayTool pauseMusicWithFileName:self.playingMusic.filename];
        //playingMusic:self.playingMusic.filename;
    //    [self addCurrentTimer];

    }
    else{
        self.playOrPauseButton.selected = NO;
        [AudioPlayTool playMusicWithFileName:self.playingMusic.filename];
      //  [self removeCurrentTimer];

    }
}

/**
   上一首
 */
- (IBAction)previous:(id)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.userInteractionEnabled = NO;
    [AudioPlayTool stopMusicWithFileName:self.playingMusic.filename];
    //stopMusic:self.playingMusic.filename;
    [SLMusicTool setPlayingMusic:[SLMusicTool previousMusic]];

    [self startPlayingMusic];
    window.userInteractionEnabled = YES;
}
/**
   下一首
 */
- (IBAction)next:(id)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.userInteractionEnabled = NO;
    //self.playingMusic.filename
    [AudioPlayTool stopMusicWithFileName:self.playingMusic.filename];
    [SLMusicTool setPlayingMusic:[SLMusicTool nextMusic]];

    [self startPlayingMusic];
    window.userInteractionEnabled = YES;
}

- (IBAction)exitBtnClick:(id)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:0.5 animations:^{
        self.view.y = window.bounds.size.height;
    } completion:^(BOOL finished) {
        self.view.hidden = YES;
    }];
}

@end
