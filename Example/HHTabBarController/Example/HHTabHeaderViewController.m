//
//  HHTabHeaderViewController.m
//  HHTabBarController_Example
//
//  Created by 崔辉辉 on 2020/9/2.
//  Copyright © 2020 888888888@qq.com. All rights reserved.
//

#import "HHTabHeaderViewController.h"
#import "HHTableViewController.h"
#import <MJRefresh.h>
#import <HHUtils-Swift.h>
#import <HHTabBarController-Swift.h>

@interface HHTabHeaderViewController ()
@property (nonatomic, strong)HHTabContentView *tabContentView;
@property (nonatomic, strong)UIView *headerView;
@end
#define WEAKSELF                        __weak __typeof(self) weakSelf = self;
@implementation HHTabHeaderViewController
static CGFloat const tabBarHeight = 44;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
    //流海屏 页面上下偏移
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabContentView = [[HHTabContentView alloc]init];
    [self.view addSubview:self.tabContentView];
    WEAKSELF
    [self requestData:^{
        //设置subViews
        [weakSelf setUpSubViews];
    }];
}
- (void)requestData:(void(^)(void))block {
    //1.网络请求开始
    //2.网络请求成功
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}
- (void)setUpSubViews {
    //先设置controllers，再设置frame
    [self initViewControllers];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"headerimg" ofType:@"png"];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    self.headerView = imageView;
    
    [self.tabContentView setHeaderWithHeaderView:self.headerView
                                           style:HHTabHeaderStyleOnlyUp
                                    headerHeight:250
                                    tabBarHeight:tabBarHeight
                           tabBarStopOnTopHeight:5
                                           frame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - [UIDevice vg_navigationFullHeight])];
    
    self.tabContentView.interceptRightSlideGuetureInFirstPage = YES;
    
    self.tabContentView.tabBar.itemTitleColor = [UIColor lightGrayColor];
    self.tabContentView.tabBar.itemTitleSelectedColor = [UIColor redColor];
    self.tabContentView.tabBar.itemTitleFont = [UIFont systemFontOfSize:17];
    self.tabContentView.tabBar.itemTitleSelectedFont = [UIFont systemFontOfSize:22];
    
    //    self.tabBar.indicatorAnimationStyle = HHTabBarIndicatorAnimationStyleDefault;
    self.tabContentView.tabBar.indicatorImageView.backgroundColor = [UIColor redColor];
    [self.tabContentView.tabBar setIndicatorInsets:UIEdgeInsetsMake(40, 10, 0, 10)];
    self.tabContentView.tabBar.selectedItemIndex = 0;
    [self addRefreshHeader];
    self.tabContentView.backgroundColor = [UIColor blueColor];
}
#pragma mark - 添加刷新
- (void)addRefreshHeader
{
    WEAKSELF
    self.tabContentView.containerTableView.mj_header = ({
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf requestData:^{
                //设置subViews
                [weakSelf setUpSubViews];
            }];
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        header;
    });
}

- (void)initViewControllers {
    HHTableViewController *controller1 = [[HHTableViewController alloc] init];
    controller1.title = @"第一个";
    
    HHTableViewController *controller2 = [[HHTableViewController alloc] init];
    controller2.title = @"第二";
    
    HHTableViewController *controller3 = [[HHTableViewController alloc] init];
    controller3.title = @"第三个";
    controller3.numberOfRows = 5;
    
    HHTableViewController *controller4 = [[HHTableViewController alloc] init];
    controller4.title = @"第四";
    
    self.tabContentView.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, controller3, controller4, nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
