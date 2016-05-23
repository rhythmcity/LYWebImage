//
//  LYWebImageCache.m
//  LYWebImage
//
//  Created by 李言 on 16/5/23.
//  Copyright © 2016年 李言. All rights reserved.
//

#import "LYWebImageCache.h"

@implementation LYWebImageCache
+ (LYWebImageCache *)shareManagre {
    static LYWebImageCache *_webImageCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _webImageCache = [[LYWebImageCache alloc] init];
    });
    return _webImageCache;
}

@end
