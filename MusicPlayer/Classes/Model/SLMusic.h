//
//  SLMusic.h
//  MusicPlayer
//
//  Created by Alfh on 16/6/4.
//  Copyright © 2016年 Alfh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLMusic : NSObject
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *icon;
@property (nonatomic, copy)NSString *filename;
@property (nonatomic, copy)NSString *lrcname;
@property (nonatomic, copy)NSString *singer;
@property (nonatomic, copy)NSString *singerIcon;
@end
