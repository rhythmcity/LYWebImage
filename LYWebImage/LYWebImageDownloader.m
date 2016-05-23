//
//  LYWebImageDownloader.m
//  LYWebImage
//
//  Created by 李言 on 16/5/23.
//  Copyright © 2016年 李言. All rights reserved.
//

#import "LYWebImageDownloader.h"
@interface LYWebImageDownloader()
@property (nonatomic, strong)NSMutableData *imageData;
@property (nonatomic, assign)NSInteger expectedSize;
@end
@implementation LYWebImageDownloader

static dispatch_queue_t ly_url_session_manager_creation_queue() {
    static dispatch_queue_t ly_url_session_manager_creation_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ly_url_session_manager_creation_queue = dispatch_queue_create("com.lywebimage.networking.session.manager.creation", DISPATCH_QUEUE_SERIAL);
    });
    
    return ly_url_session_manager_creation_queue;
}
- (instancetype)init {
    if (self = [super init]) {
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.maxConcurrentOperationCount = 1;
        self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:self.operationQueue];

    }
    
    return self;

}

+ (LYWebImageDownloader *)shareWebImageDownloader {
    static LYWebImageDownloader *_webImageDownloader = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _webImageDownloader = [[LYWebImageDownloader alloc] init];
    });
    return _webImageDownloader;
}

- (NSURLSessionDataTask *)downloaderImageWithDownloaderWithURL:(NSURL *)url DownloaderProgressBlock:(LYDownloaderProgressBlock)progressBlock DownloaderCompletedBlock:(LYDownloaderCompleteBlock)completedBlock {

    self.progressBlock = progressBlock;
    self.completeBlock = completedBlock;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    __block NSURLSessionDataTask *dataTask = nil;
    dispatch_sync(ly_url_session_manager_creation_queue(), ^{
        dataTask =  [self.session dataTaskWithRequest:request];
    });
    
    return dataTask;

}


@end
