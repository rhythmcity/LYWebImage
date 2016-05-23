//
//  LYWebImageDownloader.m
//  LYWebImage
//
//  Created by 李言 on 16/5/23.
//  Copyright © 2016年 李言. All rights reserved.
//

#import "LYWebImageDownloader.h"

@implementation LYWebImageDownloader
+ (LYWebImageDownloader *)shareWebImageDownloader {
    static LYWebImageDownloader *_webImageDownloader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _webImageDownloader = [[LYWebImageDownloader alloc] init];
    });
    return _webImageDownloader;
}

- (LYWebImageDownloaderOperation *)downloaderImageWithDownloaderWithURL:(NSURL *)url DownloaderProgressBlock:(LYDownloaderProgressBlock)progressBlock DownloaderCompletedBlock:(LYDownloaderCompleteBlock)completedBlock {

    LYWebImageDownloaderOperation *operation = [[LYWebImageDownloaderOperation alloc] init];
    
    
   
    
    return operation;

}
@end
