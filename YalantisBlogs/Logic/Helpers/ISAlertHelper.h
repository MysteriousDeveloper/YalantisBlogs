//
//  ISAlertHelper.h
//  YalantisBlogs
//
//  Created by Egor Sobko on 26.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ISAlertHelper : NSObject
+ (void)showError:(NSError *)error forViewController:(UIViewController *)viewController;
@end
