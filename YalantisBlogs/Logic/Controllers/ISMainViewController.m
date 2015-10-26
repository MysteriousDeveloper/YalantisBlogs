//
//  ISMainViewController.m
//  YalantisBlogs
//
//  Created by Egor Sobko on 23.10.15.
//  Copyright © 2015 Egor Sobko. All rights reserved.
//
#define devicePortraitOrientation [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait

#import "ISMainViewController.h"
#import "ISBlogsManager.h"
#import "ISBlogCell.h"
#import "ISBlog.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ISAPIManager.h"
#import "ISBlogViewController.h"
#import "ISAlertHelper.h"

static NSString *const kControllerTitle = @"Main";
static NSInteger const kCellPortraitHeight = 380;
static NSInteger const kCellLandscapeHeight = 182;

@interface ISMainViewController () <ISBlogsManagerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) UIRefreshControl *refreshControl;
@property (nonatomic, strong) ISBlogsManager *blogsManager;
@end

@implementation ISMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self refreshBlogs];
}

- (void)setup {
    self.title = kControllerTitle;
    [self setupBlogManager];
    [self setupTableView];
}

- (void)setupBlogManager {
    ISAPIManager *apiManager = [[ISAPIManager alloc] init];
    self.blogsManager = [[ISBlogsManager alloc] initWithAPI:apiManager];
    self.blogsManager.delegate = self;
}

- (void)setupTableView {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshBlogs) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    self.refreshControl = refreshControl;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ISBlogCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([ISBlogCell class])];
}

- (void)setupCell:(ISBlogCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    ISBlog *blog = [self.blogsManager blogForRow:indexPath.row];
    if (blog) {
        [cell.blogImageView sd_setImageWithURL:[NSURL URLWithString:blog.imageURLString]];
        cell.blogTitleLabel.text = blog.title;
        cell.blogDescriptionLabel.text = blog.blogDescription;
        cell.blogAuthorLabel.text = blog.author;
        cell.blogViewsLabel.text = blog.viewsCount;
    }
}

- (void)refreshBlogs {
    [self.refreshControl beginRefreshing];
    [self.blogsManager loadBlogs];
}

#pragma mark - UITableViewDataSource protocol implementation
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.blogsManager numberOfBlogs];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ISBlogCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ISBlogCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[ISBlogCell alloc] init];
    }
    [self setupCell:cell withIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate protocol implementation
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ISBlog *blog = [self.blogsManager blogForRow:indexPath.row];
    if (!blog) return;
    ISBlogViewController *blogVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([ISBlogViewController class])];
    blogVC.blogURLString = blog.urlString;
    [self.navigationController pushViewController:blogVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return devicePortraitOrientation ? kCellPortraitHeight : kCellLandscapeHeight;
}

#pragma mark - ISBlogsManagerDelegate protocol implementation
- (void)blogsManager:(ISBlogsManager *)manager didFinishLoadBlogs:(NSArray<ISBlog *> *)blogs {
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
}

- (void)blogsManager:(ISBlogsManager *)manager didFailedLoadBlogs:(NSError *)error {
    [self.refreshControl endRefreshing];
    [ISAlertHelper showError:error forViewController:self];
}
@end
