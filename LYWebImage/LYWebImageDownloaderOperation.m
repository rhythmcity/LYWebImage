//
//  LYWebImageDownloaderOperation.m
//  LYWebImage
//
//  Created by 李言 on 16/5/23.
//  Copyright © 2016年 李言. All rights reserved.
//

#import "LYWebImageDownloaderOperation.h"
@interface LYWebImageDownloaderOperation ()<NSURLSessionDelegate,NSURLSessionDataDelegate>
@property (nonatomic, strong)NSURLSession *session;
@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;
@end

@implementation LYWebImageDownloaderOperation
@synthesize executing = _executing , finished = _finished;

- (instancetype)initWithRequestUrl:(NSURLRequest *)request
                          progress:(LYDownloaderProgressBlock)progressBlock
                         completed:(LYDownloaderCompleteBlock)completed {
    if (self = [super init]) {
        
        _request = request;
        _progressBlock = [progressBlock copy];
        _completeBlock = [completed copy];
        
        
    }

    
    return self;
}
- (void)start {
    
    @synchronized(self) {
        if (self.isCancelled) {
            self.finished = YES;
            [self clear];
            return;
        }
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLRequest *request = self.request;
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request];
    
    [dataTask resume];

}


- (void)cancel {
    @synchronized(self) {
        if (self.isFinished) {
            return;
        }
        
        if (self.session) {
          
            [self.session invalidateAndCancel];
        }
    }


}
- (void)clear {
    self.finished = NO;
    self.completeBlock = nil;
    self.progressBlock = nil;
    self.cancelBlock = nil;
    self.session = nil;

}


@end
