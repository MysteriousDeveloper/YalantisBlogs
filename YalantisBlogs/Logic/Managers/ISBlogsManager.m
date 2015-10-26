//
//  ISBlogsManager.m
//  YalantisBlogs
//
//  Created by Egor Sobko on 25.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//

#import "ISBlogsManager.h"
#import "ISBlogsProvider.h"
#import "ISBlog.h"
#import "ISBlog+Mapping.h"
#import <FEMDeserializer.h>

static NSString *const kBlogs = @"blogs";

@interface ISBlogsManager ()
@property (nonatomic, strong) id <ISBlogsProvider> apiManager;
@property (nonatomic, strong) NSArray *blogs;
@end

@implementation ISBlogsManager
- (instancetype)initWithAPI:(id <ISBlogsProvider>)apiManager {
    self = [super init];
    if (self) {
        if ([apiManager conformsToProtocol:@protocol(ISBlogsProvider)]) {
            _apiManager = apiManager;
        }
    }
    return self;
}

- (void)loadBlogs {
    [self.apiManager loadBlogsWithCompletion:^(NSDictionary *blogsDictionary, NSError *error) {
        if (error) {
            if ([self.delegate respondsToSelector:@selector(blogsManager:didFailedLoadBlogs:)]) {
                [self.delegate blogsManager:self didFailedLoadBlogs:error];
            }
        } else {
            NSArray *blogs = [FEMDeserializer collectionFromRepresentation:blogsDictionary[kBlogs] mapping:[ISBlog defaultMapping]];
            if (blogs.count) {
                self.blogs = blogs;
                if ([self.delegate respondsToSelector:@selector(blogsManager:didFinishLoadBlogs:)]) {
                    [self.delegate blogsManager:self didFinishLoadBlogs:blogs];
                }
            }
        }
    }];
}

- (NSInteger)numberOfBlogs {
    return self.blogs.count;
}

- (ISBlog *)blogForRow:(NSInteger)row {
    return self.blogs[row];
}
@end
