//
//  LYWebImageManager.m
//  LYWebImage
//
//  Created by 李言 on 16/5/23.
//  Copyright © 2016年 李言. All rights reserved.
//

#import "LYWebImageManager.h"

static NSString *const UIImageViewImageLoadKey = @"UIImageViewImageLoad";

@interface LYWebImageManager ()


@end
@implementation LYWebImageManager



+ (LYWebImageManager *)shareManagre {
    static LYWebImageManager *_webImageManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _webImageManager = [[LYWebImageManager alloc] init];
    });
    return _webImageManager;
}

- (NSURLSessionTask *)downLoadImageWithUrl:(NSURL *)url
                    progress:(LYDownloaderProgressBlock)progressBlock
                   completed:(LYDownloaderCompleteBlock)completedBlock {
    
    if (!url) {
        
        NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorFileDoesNotExist userInfo:nil];
        
        !completedBlock?:completedBlock(nil,nil,error,NO);
        return nil;
    }
    
    if ([url isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:(NSString *)url];
    }
    
    if (![url isKindOfClass:[NSURL class]]) {
        return nil;
    }
    
    NSURLSessionTask *task = [[LYWebImageDownloader shareWebImageDownloader] downloaderImageWithDownloaderWithURL:url DownloaderProgressBlock:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            progressBlock(receivedSize,expectedSize);
        });
        
    } DownloaderCompletedBlock:^(NSData *data, UIImage *image, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            completedBlock(data,image,error,YES);
        });
        
    }];
    
    [task resume];
    
    return task;
    
    
}


@end
