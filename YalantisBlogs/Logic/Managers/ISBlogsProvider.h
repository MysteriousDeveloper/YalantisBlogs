//
//  ISBlogsProvider.h
//  YalantisBlogs
//
//  Created by Egor Sobko on 25.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^completionBlock)(NSDictionary *, NSError *);

@protocol ISBlogsProvider <NSObject>
- (void)loadBlogsWithCompletion:(completionBlock) block;
@end
