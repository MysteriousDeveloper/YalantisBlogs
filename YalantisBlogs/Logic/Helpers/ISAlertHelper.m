//
//  ISAlertHelper.m
//  YalantisBlogs
//
//  Created by Egor Sobko on 26.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//

#import "ISAlertHelper.h"

static NSString *const kAlertTitle = @"Oh-oh";
static NSString *const kOkActionTitle = @"OK";

@implementation ISAlertHelper
+ (void)showError:(NSError *)error forViewController:(UIViewController *)viewController {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:kAlertTitle message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:kOkActionTitle style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:okAction];
    [viewController presentViewController:alertVC animated:YES completion:nil];
}
@end
