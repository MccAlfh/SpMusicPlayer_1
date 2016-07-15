//
//  AudioPlayTool.m
//  VoicePlay
//
//  Created by Alfh on 16/6/4.
//  Copyright © 2016年 Alfh. All rights reserved.
//

#import "AudioPlayTool.h"
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
@implementation AudioPlayTool

static NSMutableDictionary *soundIDs;
static NSMutableDictionary *players;
+ (void)initialize {
    soundIDs = [NSMutableDictionary dictionary];
    players = [NSMutableDictionary dictionary];
}

+(void)playAudioWithFileName:(NSString *)fileName {
    
    if (fileName == nil) {
        return;
    }
//    从字典中取出音效 ID
    SystemSoundID soundID = [soundIDs[fileName] unsignedIntegerValue];
    if (!soundID) {
//    根据文件名称加载音效 URL
        NSURL *url = [[NSBundle mainBundle]URLForResource:fileName withExtension:nil];
        if (!url) {
            return;
        }
//     创建音效 ID
        AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &soundID);
//     将 ID 添加到字典中
        soundIDs[fileName] = @(soundID);
     }
    AudioServicesPlaySystemSound(soundID);

  }

+(void)disposeAudioWithFieName:(NSString *)fileName {
    if (fileName == nil) {
        return;
    }
    //    从字典中取出音效 ID
    SystemSoundID soundID = [soundIDs[fileName] unsignedIntegerValue];
    AudioServicesDisposeSystemSoundID(soundID);
    [soundIDs removeObjectForKey:fileName];
}

+ (AVAudioPlayer *)playMusicWithFileName:(NSString *)filename {
//    0、判断文件名是否为空
    if (filename == nil) {
        return nil;
    }
//    1、从字典中取出播放器
    AVAudioPlayer *player = players[filename];
    if (!player) {
//        2、根据文件名加载 url
        NSURL *url = [[NSBundle mainBundle]URLForResource:filename withExtension:nil];
        if (!url) {
            return nil;
        }
//        3、创建播放器
        player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
//        4、准备播放
        if (![player prepareToPlay]) {
            return nil;
        }
        player.enableRate = YES;
        players[filename] = player;
    }
//    5、播放
    if (!player.playing) {
        [player play];
    }
    return player;
}

+ (void)pauseMusicWithFileName:(NSString *)filename {
    if (filename == nil) {
        return;
    }
    AVAudioPlayer *player = players[filename];
    if (player) {
        if (player.playing) {
            [player pause];
        }
    }
}

+ (void)stopMusicWithFileName:(NSString *)filename {
    if (filename == nil) {
        return;
    }
    AVAudioPlayer *player = players[filename];
    if (player) {
        [player stop];
        player = nil;
        [players removeObjectForKey:filename];
    }
}
@end
