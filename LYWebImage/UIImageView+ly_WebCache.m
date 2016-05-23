//
//  UIImageView+ly_WebCache.m
//  LYWebImage
//
//  Created by 李言 on 16/5/23.
//  Copyright © 2016年 李言. All rights reserved.
//

#import "UIImageView+ly_WebCache.h"
#import <objc/runtime.h>
#import "LYWebImageManager.h"

static NSString *const loadTaskKey = @"loadTaskKey";

static NSString *const UIImageViewImageLoadKey = @"UIImageViewImageLoad";
@implementation UIImageView (ly_WebCache)
- (NSMutableDictionary *)taskDictionary {
    NSMutableDictionary *taskDic = objc_getAssociatedObject(self, &loadTaskKey);
    if (taskDic) {
        return taskDic;
    }
    taskDic = [NSMutableDictionary dictionary];
    objc_setAssociatedObject(self, &loadTaskKey, taskDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return taskDic;
}


- (void)ly_setImageLoadTask:(NSURLSessionTask *)task forKey:(NSString *)key {
    [self ly_cancelImageLoadTaskWithKey:key];
    NSMutableDictionary *operationDictionary = [self taskDictionary];
    [operationDictionary setObject:task forKey:key];
}

- (void)ly_cancelImageLoadTaskWithKey:(NSString *)key {
    
    NSMutableDictionary *taskDictionary = [self taskDictionary];
    id tasks = [taskDictionary objectForKey:key];
    if (tasks) {
        if ([tasks isKindOfClass:[NSArray class]]) {
            for (NSURLSessionTask  * task in tasks) {
                if (task) {
                    [task cancel];
                }
            }
        } else {
            
            [(NSURLSessionTask *)tasks cancel];
            
        }
        [self.taskDictionary removeObjectForKey:key];
    }
}

- (void)ly_removeImageLoadTaskWithKey:(NSString *)key {
    NSMutableDictionary *operationDictionary = [self taskDictionary];
    [operationDictionary removeObjectForKey:key];
}


- (void)ly_setImageWithUrl:(NSURL *)url {
    
    [self ly_cancelImageLoadTaskWithKey:UIImageViewImageLoadKey];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.image = nil;
    });
    
    if (url) {
        __weak __typeof(self)wself = self;
        NSURLSessionTask *task = [[LYWebImageManager shareManagre] downLoadImageWithUrl:url progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(NSData *data, UIImage *image, NSError *error, BOOL finished) {
            
            if (!wself) {
                return ;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    if (!wself) {
                        return ;
                    }
                    
                    wself.image = image;
                    [wself setNeedsLayout];
                    
                }
            });
            
        }];
        
        [self ly_setImageLoadTask:task forKey:UIImageViewImageLoadKey];
        
    } else {
    
    
    
    }
    

}

@end
