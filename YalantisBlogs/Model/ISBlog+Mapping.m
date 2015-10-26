//
//  ISBlog+Mapping.m
//  YalantisBlogs
//
//  Created by Egor Sobko on 26.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//

#import "ISBlog+Mapping.h"
#import <FEMMapping.h>
#import "ISBlog.h"

@implementation ISBlog (Mapping)
+ (FEMMapping *)defaultMapping {
    FEMMapping *mapping = [[FEMMapping alloc] initWithObjectClass:[ISBlog class]];
    [mapping addAttributesFromArray:@[@"author", @"title", @"viewsCount"]];
    [mapping addAttributesFromDictionary:@{@"blogDescription":@"description",
                                           @"imageURLString":@"image",
                                           @"urlString":@"url"}];
    return mapping;
}
@end

