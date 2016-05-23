//
//  LYWebImageDownloaderOperation.h
//  LYWebImage
//
//  Created by 李言 on 16/5/23.
//  Copyright © 2016年 李言. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^LYDownloaderProgressBlock)(NSInteger receivedSize,NSInteger expectedSize);
typedef void(^LYDownloaderCompleteBlock)(NSData *data, UIImage *image, NSError *error,BOOL finished);
typedef void(^LYDownloaderCancelBlock)();
@interface LYWebImageDownloaderTask : NSObject

@property (nonatomic, copy)LYDownloaderProgressBlock progressBlock;
@property (nonatomic, copy)LYDownloaderCompleteBlock completeBlock;
@property (nonatomic, copy)LYDownloaderCancelBlock  cancelBlock;

@property (nonatomic, strong,readonly)NSURLRequest *request;

@property (nonatomic, assign)NSInteger expectedSize;

- (instancetype)initWithRequestUrl:(NSURLRequest *)request
                          progress:(LYDownloaderProgressBlock)progressBlock
                         completed:(LYDownloaderCompleteBlock)completed;
- (NSURLSessionTask *)start;
@end
