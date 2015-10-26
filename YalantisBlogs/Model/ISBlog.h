//
//  ISBlog.h
//  YalantisBlogs
//
//  Created by Egor Sobko on 25.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ISBlog : NSObject
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *blogDescription;
@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSString *viewsCount;
@end
