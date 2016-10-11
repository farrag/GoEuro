//
//  CustomNavigationViewController.m
//  GeEuro
//
//  Created by Ahmad Farrag on 10/10/16.
//  Copyright © 2016 Ahmad Farrag. All rights reserved.
//

#import "CustomNavigationViewController.h"
#import "Colors.h"

@interface CustomNavigationViewController ()

@end

@implementation CustomNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = [[Colors getInstance] mainColor];
    self.navigationBar.translucent = NO;
    
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    [self.navigationBar setTitleTextAttributes:@{
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]
                                                 }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
