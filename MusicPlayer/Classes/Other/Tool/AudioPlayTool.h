//
//  AudioPlayTool.h
//  VoicePlay
//
//  Created by Alfh on 16/6/4.
//  Copyright © 2016年 Alfh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioPlayTool : NSObject


+ (void)playAudioWithFileName:(NSString *)fileName;
+ (void)disposeAudioWithFieName:(NSString *)fileName;

+ (AVAudioPlayer *)playMusicWithFileName:(NSString *)filename;
+ (void)pauseMusicWithFileName:(NSString *)filename;
+ (void)stopMusicWithFileName:(NSString *)filename;
@end
