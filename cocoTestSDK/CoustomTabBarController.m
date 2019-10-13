//
//  CoustomTabBarController.m
//  Wireframe
//
//  Created by zxj on 2019/1/22.
//  Copyright © 2019 zxj. All rights reserved.
//

#import "CoustomTabBarController.h"


@interface CoustomTabBarController ()<UITabBarControllerDelegate>{
    
}

@end

@implementation CoustomTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coustomTabBar = [[MyTabBar alloc] init];
    [self setValue:self.coustomTabBar forKey:@"tabBar"];
     __weak typeof(self) weakSelf = self;
    [[self.coustomTabBar.addButton rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.selectedIndex = 2;
            strongSelf.coustomTabBar.addButton.selected=YES;
            NSInteger tabitem = 2;
            [[strongSelf.viewControllers objectAtIndex:tabitem] popToRootViewControllerAnimated:NO];
            [[strongSelf.viewControllers objectAtIndex:tabitem].presentedViewController dismissViewControllerAnimated:NO completion:nil];
        }
    }];
    [self addChildViewControllers];
    self.delegate = self;
    
}


- (void)addChildViewControllers{
    
    [self addChildrenViewController:[[NestViewController alloc] init] andTitle:LOCALIZATION(@"tabBar_lifeLog") andImageName:@"icon_menu_book_grey" andSelectImage:@"icon_menu_book_red"];
    [self addChildrenViewController:[[couponsViewController alloc] init] andTitle:LOCALIZATION(@"tabBar_coupons") andImageName:@"icon_menu_coupon_grey" andSelectImage:@"icon_menu_coupon_red"];
    [self addChildrenViewController:[[homeViewController alloc] init] andTitle:LOCALIZATION(@"tabBar_home") andImageName:@"" andSelectImage:@""];
    [self addChildrenViewController:[[shopsLocationViewController alloc] init] andTitle:LOCALIZATION(@"tabBar_shopsLocations") andImageName:@"icon_menu_store_grey" andSelectImage:@"icon_menu_store_red"];
    [self addChildrenViewController:[[moreViewController alloc] init] andTitle:LOCALIZATION(@"tabBar_more") andImageName:@"icon_menu_more_grey" andSelectImage:@"icon_menu_more_red"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    
    UIImage * Image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   childVC.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:Image selectedImage:selImage];

    
    if (@available(iOS 10.0, *)) {
         self.tabBar.unselectedItemTintColor = TABBAR_NORMALTitleCOLOR;
         [childVC.tabBarItem setTitleTextAttributes: @{NSForegroundColorAttributeName:TABBAR_NORMALTitleCOLOR} forState:UIControlStateNormal];
         [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:TABBAR_SELECTTitleCOLOR} forState:UIControlStateSelected];
     } else {
        [childVC.tabBarItem setTitleTextAttributes: @{NSForegroundColorAttributeName:TABBAR_NORMALTitleCOLOR} forState:UIControlStateNormal];
        [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:TABBAR_SELECTTitleCOLOR} forState:UIControlStateSelected];
     }
     
   UINavigationController *baseNav = [[UINavigationController alloc] initWithRootViewController:childVC];
   [self addChildViewController:baseNav];
    
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    self.coustomTabBar.addButton.selected=NO;
    NSInteger tabitem = tabBarController.selectedIndex;
    [[tabBarController.viewControllers objectAtIndex:tabitem] popToRootViewControllerAnimated:NO];
    [[tabBarController.viewControllers objectAtIndex:tabitem].presentedViewController dismissViewControllerAnimated:NO completion:nil];
}



@end
