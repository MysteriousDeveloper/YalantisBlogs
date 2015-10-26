//
//  ISBlogCell.h
//  YalantisBlogs
//
//  Created by Egor Sobko on 25.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISBlogCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView *blogImageView;
@property (nonatomic, weak) IBOutlet UILabel *blogTitleLabel;
@property (nonatomic, weak) IBOutlet UILabel *blogDescriptionLabel;
@property (nonatomic, weak) IBOutlet UILabel *blogAuthorLabel;
@property (nonatomic, weak) IBOutlet UILabel *blogViewsLabel;

@end
