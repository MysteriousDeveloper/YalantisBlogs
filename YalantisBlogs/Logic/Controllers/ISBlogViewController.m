//
//  ISBlogViewController.m
//  YalantisBlogs
//
//  Created by Egor Sobko on 25.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//

#import "ISBlogViewController.h"
#import "ISAlertHelper.h"

static NSString *const kControllerName = @"Blog reader";

@interface ISBlogViewController () <UIWebViewDelegate>
@property (nonatomic, weak) IBOutlet UIWebView *webView;

@end

@implementation ISBlogViewController
-(void)dealloc {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    if (self.blogURLString) {
        NSURLRequest *blogRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:self.blogURLString]];
        [self.webView loadRequest:blogRequest];
    }
}

- (void)setup {
    self.title = kControllerName;
    self.webView.delegate = self;
}

#pragma mark - UIWebViewDelegate protocol implementation
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [ISAlertHelper showError:error forViewController:self];
}

@end
