//
//  ISBlogsManager.h
//  YalantisBlogs
//
//  Created by Egor Sobko on 25.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISBlogsProvider.h"

@class ISBlogsManager,ISBlog;
@protocol ISBlogsManagerDelegate <NSObject>

- (void)blogsManager:(ISBlogsManager *)manager didFinishLoadBlogs:(NSArray<ISBlog *> *)blogs;
- (void)blogsManager:(ISBlogsManager *)manager didFailedLoadBlogs:(NSError *)error;

@end

@interface ISBlogsManager : NSObject
@property (nonatomic, weak) id <ISBlogsManagerDelegate> delegate;

- (instancetype)initWithAPI:(id <ISBlogsProvider>)apiManager;
- (void)loadBlogs;
- (NSInteger)numberOfBlogs;
- (ISBlog *)blogForRow:(NSInteger)row;
@end
