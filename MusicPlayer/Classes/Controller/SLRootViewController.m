//
//  SLRootViewController.m
//  MusicPlayer
//
//  Created by Alfh on 16/6/4.
//  Copyright © 2016年 Alfh. All rights reserved.
//

#import "SLRootViewController.h"
#import "SLPlayingViewController.h"
#import "MJExtension.h"
#import "SLMusic.h"
#import "UIImage+NJ.h"
#import "Colours.h"
#import "SLMusicTool.h"


@interface SLRootViewController ()
//@property (nonatomic, strong) NSArray *musics;

@property (nonatomic,strong) SLPlayingViewController *playingViewController;
@end

@implementation SLRootViewController

//- (NSArray *)musics {
//    if (!_musics) {
//        _musics = [SLMusic objectArrayWithFilename:@"Musics.plist"];
//    }
//    return _musics;
//}

- (SLPlayingViewController *)playingViewController {
    if (_playingViewController == nil) {
        _playingViewController = [[SLPlayingViewController alloc]init];
    }
    return _playingViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[SLMusicTool musics]count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"music";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    SLMusic *music = [SLMusicTool musics][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:music.singerIcon];
    cell.imageView.image = [UIImage circleImageWithName:music.singerIcon borderWidth:5.0 borderColor:[UIColor skyBlueColor]];
    cell.textLabel.text = music.name;
    cell.detailTextLabel.text = music.singer;
    return cell;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];//取消选中
//    [self performSegueWithIdentifier:@"musics2playing" sender:nil];
    [SLMusicTool setPlayingMusic:[SLMusicTool musics][indexPath.row]];
    [self.playingViewController show];
}
@end
