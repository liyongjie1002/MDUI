//
//  MDPushTransition.m
//  MDUI_Example
//
//  Created by 李永杰 on 2019/8/2.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDPushTransition.h"

@implementation MDPushTransition

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    //to
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView* toView = nil;
    UIView* fromView = nil;
    //UITransitionContextFromViewKey和UITransitionContextToViewKey定义在iOS8.0以后的SDK中，所以在iOS8.0以下SDK中将toViewController和fromViewController的view设置给toView和fromView
    //iOS8.0 之前和之后view的层次结构发生变化，所以iOS8.0以后UITransitionContextFromViewKey获得view并不是fromViewController的view
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    //这个非常重要，将toView加入到containerView中
    [[transitionContext containerView]  addSubview:toView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    toView.frame = CGRectMake(0, height, width, height);
    toView.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.frame = CGRectMake(0, 0, width, height);
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}
@end
