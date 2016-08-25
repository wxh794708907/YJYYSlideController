//
//  YJYYMainViewController.m
//  YJYYSlideControls
//
//  Created by 遇见远洋 on 16/8/25.
//  Copyright © 2016年 遇见远洋. All rights reserved.
//

#import "YJYYMainViewController.h"
#import "YJYYFirstViewController.h"
#import "YJYYSecondViewController.h"
#import "YJYYThirdViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface YJYYMainViewController ()<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView *mainScrollView;/**<滚动scrollView*/
@property (strong,nonatomic)YJYYFirstViewController *firstVc;/**<第一个控制器*/
@property (strong,nonatomic)YJYYSecondViewController *secondVc;/**<第二个控制器*/
@property (strong,nonatomic)YJYYThirdViewController *thirdVc;/**<第三个控制器*/
@property (strong,nonatomic)UIView *btnContainerView;/**<按钮容器视图*/
@property (strong,nonatomic)UILabel *slideLabel;/**<滚动条*/
@property (strong,nonatomic)NSMutableArray *btnsArray;/**<按钮数组*/


@end

@implementation YJYYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置scrollView
    [self setMainSrollView];
}

/**
 *  设置scrollView
 */
-(void)setMainSrollView{
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height)];
    _mainScrollView.delegate = self;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
    NSArray *views = @[self.firstVc.view,self.secondVc.view,self.thirdVc.view];
    for (NSInteger i = 0; i<self.btnsArray.count; i++) {
        //把三个vc的view依次贴到_mainScrollView上面
        UIView *pageView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth*i, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height-100)];
        [pageView addSubview:views[i]];
        [_mainScrollView addSubview:pageView];
    }
    _mainScrollView.contentSize = CGSizeMake(kScreenWidth*(views.count), 0);
}


/**
 *  标签按钮点击
 *
 *  @param sender 按钮
 */
-(void)sliderAction:(UIButton *)sender{
    [self sliderAnimationWithTag:sender.tag];
    [UIView animateWithDuration:0.3 animations:^{
        _mainScrollView.contentOffset = CGPointMake(kScreenWidth*(sender.tag), 0);
    } completion:^(BOOL finished) {
        
    }];
}


/**
 *  滑动scrollView以及改变sliderLabel位置
 *
 *  @param tag 按钮tag
 */
-(void)sliderAnimationWithTag:(NSInteger)tag{
    [self.btnsArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.selected = NO;
    }];
    //获取被选中的按钮
    UIButton *selectedBtn = self.btnsArray[tag];
    selectedBtn.selected = YES;
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        _slideLabel.center = CGPointMake(selectedBtn.center.x, _slideLabel.center.y);
    } completion:^(BOOL finished) {
        [self.btnsArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        }];
        selectedBtn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
    }];
}


#pragma mark- XXXXXXXXXXXXXXX懒加载XXXXXXXXXXXXXXXXXXXX
- (YJYYFirstViewController *)firstVc {
    if (!_firstVc) {
        _firstVc = [[YJYYFirstViewController alloc]init];
    }
    return _firstVc;
}

- (YJYYSecondViewController *)secondVc {
    if (!_secondVc) {
        _secondVc = [[YJYYSecondViewController alloc]init];
    }
    return _secondVc;
}

- (YJYYThirdViewController *)thirdVc {
    if (!_thirdVc) {
        _thirdVc = [[YJYYThirdViewController alloc]init];
    }
    return _thirdVc;
}


- (NSMutableArray *)btnsArray {
    if (!_btnsArray) {
        _btnsArray = [NSMutableArray array];
        self.btnContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        self.navigationItem.titleView = _btnContainerView;
        
        _slideLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40-2, kScreenWidth/3, 4)];
        _slideLabel.backgroundColor = [UIColor redColor];
        
        [_btnContainerView addSubview:_slideLabel];
        
        for (int i = 0; i < 3; i++) {
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.frame = CGRectMake(i*kScreenWidth/3 - 10,0, kScreenWidth/3, _btnContainerView.frame.size.height);
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
            [btn addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[NSString stringWithFormat:@"第%d个",i] forState:UIControlStateNormal];
            btn.tag = i;
            [_btnsArray addObject:btn];
            if (i == 0) {
                btn.selected = YES;
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:19];
                
            }
            [_btnContainerView addSubview:btn];
        }
    }
    return _btnsArray;
}


//scrollView滑动代理监听
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double index_ = scrollView.contentOffset.x/kScreenWidth;
    [self sliderAnimationWithTag:(int)(index_+0.5)];
}

@end
