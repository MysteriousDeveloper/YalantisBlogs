//
//  ISApiManager.h
//  YalantisBlogs
//
//  Created by Egor Sobko on 25.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISBlogsProvider.h"

@interface ISAPIManager : NSObject <ISBlogsProvider>
- (void)loadBlogsWithCompletion:(completionBlock) block;
@end
