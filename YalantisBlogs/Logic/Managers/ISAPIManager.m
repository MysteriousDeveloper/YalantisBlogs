//
//  ISApiManager.m
//  YalantisBlogs
//
//  Created by Egor Sobko on 25.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//

#import "ISAPIManager.h"
#import <OHHTTPStubs/OHHTTPStubs.h>

@implementation ISAPIManager
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)loadBlogsWithCompletion:(completionBlock)block {
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    NSURL *url = [NSURL URLWithString:@"https://yalantis.com/blog/"];
    NSURLSessionDataTask *getBlogsTask = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && !error) {
            NSDictionary *blogs;
            NSError *jsonError;
            @try {
                blogs = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            } @catch (NSException *exception) {
                NSLog(@"Exception : %@", exception);
                return;
            }
            if (jsonError) {
                NSLog(@"%@", [jsonError localizedDescription]);
                if (block) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(nil, jsonError);
                    });
                }
            } else {
                if (block) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(blogs, jsonError);
                    });
                }
            }
        } else {
            if (block) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(nil, error);
                });
            }
        }
    }];
    [getBlogsTask resume];
}

#pragma mark - Private
- (void)setup {
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:@"https://yalantis.com/blog/"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString *responsePath = [[NSBundle mainBundle] pathForResource:@"yalantis" ofType:@"json"];
        return [OHHTTPStubsResponse responseWithFileAtPath:responsePath
                                                statusCode:200
                                                   headers:@{@"Content-Type":@"application/json"}];
    }];
}
@end
