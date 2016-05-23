//
//  LYWebImageDownloaderOperation.m
//  LYWebImage
//
//  Created by 李言 on 16/5/23.
//  Copyright © 2016年 李言. All rights reserved.
//

#import "LYWebImageDownloaderTask.h"
@interface LYWebImageDownloaderTask ()<NSURLSessionDelegate,NSURLSessionDataDelegate>
@property (nonatomic, strong)NSURLSession *session;
@property (nonatomic, strong)NSMutableData *imageData;
@property (assign, nonatomic, getter = isExecuting) BOOL executing;
@property (assign, nonatomic, getter = isFinished) BOOL finished;
@end

@implementation LYWebImageDownloaderTask
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
- (NSURLSessionTask *)start {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
    NSURLRequest *request = self.request;
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request];
    
    return dataTask;
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

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    self.imageData = [[NSMutableData alloc] init];
    self.expectedSize = response.expectedContentLength;
    if (dataTask.state == NSURLSessionTaskStateCanceling) {
        _imageData = nil;
    }
    if (self.progressBlock) {
        self.progressBlock(0,self.expectedSize);
    }
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data{
    
    [self.imageData appendData:data];
    if (self.progressBlock) {
        self.progressBlock(self.imageData.length,self.expectedSize);
    }
    
}


-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    if (!error) {
        UIImage *image = [UIImage imageWithData:self.imageData];
        self.completeBlock(self.imageData,image,nil,YES);
        [task cancel];
        
    }else{
        self.completeBlock(self.imageData,nil,error,NO);
        [task cancel];
        
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
