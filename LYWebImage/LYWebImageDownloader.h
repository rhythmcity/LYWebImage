//
//  LYWebImageDownloader.h
//  LYWebImage
//
//  Created by 李言 on 16/5/23.
//  Copyright © 2016年 李言. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LYWebImageDownloaderOperation.h"

typedef void(^LYDownloaderProgressBlock)(NSInteger receivedSize,NSInteger expectedSize);
typedef void(^LYDownloaderCompleteBlock)(NSData *data, UIImage *image, NSError *error,BOOL finished);

@interface LYWebImageDownloader : NSObject

@property (nonatomic, strong)NSOperationQueue *operationQueue;

@property (nonatomic, strong)NSURLSession *session;
+ (LYWebImageDownloader *)shareWebImageDownloader;

- (LYWebImageDownloaderOperation *)downloaderImageWithDownloaderWithURL:(NSURL *)url DownloaderProgressBlock:(LYDownloaderProgressBlock)progressBlock DownloaderCompletedBlock:(LYDownloaderCompleteBlock)completedBlock;
@end
