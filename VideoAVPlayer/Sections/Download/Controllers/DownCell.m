//
//  DownCell.m
//  VideoAVPlayer
//
//  Created by gaoyanlong on 15-3-16.
//  Copyright (c) 2015年 shaowenle. All rights reserved.
//

#import "DownCell.h"
#import "AFURLSessionManager.h"
#import "UIProgressView+AFNetworking.h"
#import "DownDate.h"

@implementation DownCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)down:(UIButton *)sender {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.URL];
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        [sender setTitle:@"下载完成" forState:UIControlStateNormal];
        [sender setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        sender.userInteractionEnabled = NO;
        DownDate *downData = [DownDate shareDownDate];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"亲" message:@"视频下载好了" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
        NSLog(@"File downloaded to: %@", filePath);
        downData.file = filePath;
    }];
    [_downProgressView setProgressWithDownloadProgressOfTask:downloadTask animated:YES];
    [downloadTask resume];
}

@end
