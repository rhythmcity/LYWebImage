//
//  LYWebImageManager.h
//  LYWebImage
//
//  Created by 李言 on 16/5/23.
//  Copyright © 2016年 李言. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LYWebImageDownloader.h"
@interface LYWebImageManager : NSObject

+ (LYWebImageManager *)shareManagre;

- (NSURLSessionTask *)downLoadImageWithUrl:(NSURL *)url
                    progress:(LYDownloaderProgressBlock)progressBlock
                   completed:(LYDownloaderCompleteBlock)completedBlock;
@end
