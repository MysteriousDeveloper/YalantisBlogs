//
//  ISBlog.m
//  YalantisBlogs
//
//  Created by Egor Sobko on 25.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//

#import "ISBlog.h"

static NSString *kHostString = @"https://www.yalantis.com";

@implementation ISBlog

- (void)setImageURLString:(NSString *)imageURLString {
    if (imageURLString != _imageURLString) {
        _imageURLString = [kHostString stringByAppendingString:imageURLString];
    }
}

- (void)setUrlString:(NSString *)urlString {
    if (urlString != _urlString) {
        _urlString = [kHostString stringByAppendingString:urlString];
    }
}

-(NSString *)description {
    return [NSString stringWithFormat:@"author - %@,\n"
                                       "blogDescription - %@,\n"
                                       "imageURLString - %@,\n"
                                       "title - %@,\n"
                                       "urlString - %@,\n"
                                       "viewsCount - %@,\n", self.author, self.blogDescription, self.imageURLString, self.title, self.urlString, self.viewsCount];
}
@end
