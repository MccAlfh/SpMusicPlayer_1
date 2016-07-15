//
//  SLMusicTool.h
//  MusicPlayer
//
//  Created by Alfh on 16/6/4.
//  Copyright © 2016年 Alfh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SLMusic;
@interface SLMusicTool : NSObject
+ (NSArray *)musics;

+ (void)setPlayingMusic:(SLMusic *)music;

+ (SLMusic *)playingMusic;

+ (SLMusic *)nextMusic;

+ (SLMusic *)previousMusic;

@end
