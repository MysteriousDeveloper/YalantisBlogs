//
//  ISBlog+Mapping.h
//  YalantisBlogs
//
//  Created by Egor Sobko on 26.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//

#import "ISBlog.h"

@class FEMMapping;
@interface ISBlog (Mapping)
    
+ (FEMMapping *)defaultMapping;
@end
