//
//  MainViewController.m
//  GeEuro
//
//  Created by Ahmad Farrag on 10/9/16.
//  Copyright © 2016 Ahmad Farrag. All rights reserved.
//

#import "MainViewController.h"
#import "BusViewController.h"
#import "TrainViewController.h"
#import "FlightViewController.h"
#import "YSLContainerViewController.h"
#import "Colors.h"

@interface MainViewController ()

@property (nonatomic, strong) UIColor *mainColor;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Magic Could Be DONE";
    
    _mainColor = [UIColor colorWithRed:23/255.0 green:99/255.0 blue:161/255.0 alpha:1];

    BusViewController *busViewController = [[BusViewController alloc] init];
    busViewController.title = @"Bus";

    // These two Controller not implement for now, these implementations should looks like the BusViewController
    // I Spent the effort in that Controller for now.
    BusViewController *trainViewController = [[BusViewController alloc] init];
    trainViewController.title = @"Train";
    
    BusViewController *flightViewController = [[BusViewController alloc] init];
    flightViewController.title = @"Flight";
        
    YSLContainerViewController *containerViewController = [[YSLContainerViewController alloc] initWithControllers:@[
                                                                                                                    busViewController,
                                                                                                                    trainViewController,
                                                                                                                    flightViewController
                                                                                                                    ]
                                                                                                     topBarHeight:0
                                                                                             parentViewController:self];
    
    containerViewController.menuItemTitleColor = [UIColor colorWithWhite:1 alpha:0.7];
    containerViewController.menuItemSelectedTitleColor = [UIColor whiteColor];
    containerViewController.menuIndicatorColor = [Colors getInstance].menuIndicatorColor;
    containerViewController.menuBackGroudColor = [Colors getInstance].mainColor;
    [self.view addSubview:containerViewController.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
