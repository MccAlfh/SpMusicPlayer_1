//
//  SLMusicTool.m
//  MusicPlayer
//
//  Created by Alfh on 16/6/4.
//  Copyright © 2016年 Alfh. All rights reserved.
//

#import "SLMusicTool.h"
#import "SLMusic.h"
#import "MJExtension.h"

@implementation SLMusicTool
static NSArray *_musics;
static SLMusic *_playingMusic;

+ (NSArray *)musics {
    if (!_musics) {
        _musics = [SLMusic objectArrayWithFilename:@"Musics.plist"];
    }
    return _musics;
}

+ (void)setPlayingMusic:(SLMusic *)music {
    if (!music || ![[self musics] containsObject:music]) {
        return;
    }
    _playingMusic = music;
}

+ (SLMusic *)playingMusic {
    return _playingMusic;
}

+ (SLMusic *)nextMusic {
//    1、获取当前播放索引
    NSInteger currentIndex = [[self musics] indexOfObject:_playingMusic];
//    2、计算下一首的索引
    NSInteger nextIndex = currentIndex + 1;
//    3、越界处理
    if (nextIndex >= [[self musics] count]) {
        nextIndex = 0;
    }
//    4、取出下一首的模型
    return [self musics][nextIndex];
//    
}

+ (SLMusic *)previousMusic {
    //    1、获取当前播放索引
    NSInteger currentIndex = [[self musics] indexOfObject:_playingMusic];
    //    2、计算下一首的索引
    NSInteger previousIndex = currentIndex - 1;
    //    3、越界处理
    if (previousIndex < 0) {
        previousIndex = [[self musics] count] - 1;
    }
    //    4、取出下一首的模型
    return [self musics][previousIndex];
}

@end

